# azure-ansible-gitlab

## First step - create the VM

    $ cd terraform
    $ terraform init
    $ terraform apply -var-file ../config/azure-gitlab-server.tfvars
    
## Second step - initialize the server

    $ cd ../ansible
 
build ansible docker image with:

    $ docker build -t keyteo/gitlab/ansible .

once the image built, run the inital configuration (install needed packages and so on) with:

    $ docker run --rm -it keyteo/gitlab/ansible

(which is going to use the gitlab-install-playbook by default)

## Third step - configure the server

Once the gitlab server is installed, don't forget to connect once on it to set up the root password.
http://keyteo-gitlab.westeurope.cloudapp.azure.com/

stay in ansible directory, then run:

    $ docker run -e GITLAB_USER_PASSWORD=A3XAjS3kWcT6QKpm -e GITLAB_ROOT_PASSWORD=3sc4l@t0r --rm -it keyteo/gitlab/ansible /ansible/playbooks/gitlab-config-playbook.yml
    
to use the config playbook.

## Next steps - configure CI/CD

Start by registering a SSH config in your home directory:

    $ /v/d/w/simpleblog (master)> cat ~/.ssh/config 
    Host keyteo-gitlab.westeurope.cloudapp.azure.com
        IdentityFile /var/data/workspaces/azure-ansible-gitlab/ansible/admgitlab.rsa
        User admgitlab

Then, ssh to 'keyteo-gitlab.westeurope.cloudapp.azure.com' and register the gitlab-runner:

    admgitlab@keyteo-gitlab:~$ sudo gitlab-runner register
    Runtime platform                                    arch=amd64 os=linux pid=12802 revision=7f00c780 version=11.5.1
    Running in system-mode.                            
                                                       
    Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
    http://keyteo-gitlab.westeurope.cloudapp.azure.com/
    Please enter the gitlab-ci token for this runner:
    7gMJca2Ch-Wi_iYzRiVY
    Please enter the gitlab-ci description for this runner:
    [keyteo-gitlab]: 
    Please enter the gitlab-ci tags for this runner (comma separated):
    python
    Registering runner... succeeded                     runner=7gMJca2C
    Please enter the executor: docker, ssh, virtualbox, docker+machine, kubernetes, docker-ssh, parallels, shell, docker-ssh+machine:
    shell
    Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 

Enter the token that you will found here:
http://keyteo-gitlab.westeurope.cloudapp.azure.com/admin/runners

then restart your runner:

    admgitlab@keyteo-gitlab:~$ sudo systemctl restart gitlab-runner
    admgitlab@keyteo-gitlab:~$ sudo systemctl status gitlab-runner
    ● gitlab-runner.service - GitLab Runner
       Loaded: loaded (/etc/systemd/system/gitlab-runner.service; enabled; vendor preset: enabled)
       Active: active (running) since Mon 2018-12-17 20:32:43 UTC; 2s ago
     Main PID: 12088 (gitlab-runner)
        Tasks: 7 (limit: 4915)
       CGroup: /system.slice/gitlab-runner.service
               └─12088 /usr/lib/gitlab-runner/gitlab-runner run --working-directory /home/gitlab-runner --config /etc/gitlab

    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]: Running in system-mode.                           
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]: Running in system-mode.                           
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]:                                                   
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]:                                                   
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]: Configuration loaded                                builds=0
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]: Configuration loaded                                builds=0
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]: Listen address not defined, metrics server disabled  builds=0
    Dec 17 20:32:43 keyteo-gitlab gitlab-runner[12088]: Listen address not defined, metrics server disabled  builds=0


Finally, add the sample project to gitlab:

    $ /v/d/workspaces> git config --global user.name "Francois Colombo"
    $ /v/d/workspaces> git config --global user.email "francois_colombo@yahoo.fr"
    $ /v/d/workspaces> git clone 
    $ /v/d/workspaces> cd simpleblog
    $ /v/d/w/simpleblog (master)> cp -R ../azure-ansible-gitlab/simpleblog/* .
    $ /v/d/w/simpleblog (master)> cp ../azure-ansible-gitlab/simpleblog/.gitignore .
    $ /v/d/w/simpleblog (master)> cp ../azure-ansible-gitlab/simpleblog/.gitlab-ci.yml .
    $ /v/d/w/simpleblog (master)> ll -a
    total 44K
    drwxr-xr-x 5 fcolombo fcolombo 4.0K Dec 17 21:22 ./
    drwxrwxr-x 5 fcolombo fcolombo 4.0K Dec 17 21:20 ../
    -rw-r--r-- 1 fcolombo fcolombo  121 Dec 17 21:21 deploy.sh
    drwxr-xr-x 7 fcolombo fcolombo 4.0K Dec 17 21:21 .git/
    -rw-r--r-- 1 fcolombo fcolombo   97 Dec 17 21:22 .gitignore
    -rw-r--r-- 1 fcolombo fcolombo 1.6K Dec 17 21:22 .gitlab-ci.yml
    -rw-r--r-- 1 fcolombo fcolombo  101 Dec 17 21:21 MANIFEST.in
    -rw-r--r-- 1 fcolombo fcolombo   81 Dec 17 21:21 setup.cfg
    -rw-r--r-- 1 fcolombo fcolombo  226 Dec 17 21:21 setup.py
    drwxr-xr-x 4 fcolombo fcolombo 4.0K Dec 17 21:21 simpleblog/
    drwxr-xr-x 2 fcolombo fcolombo 4.0K Dec 17 21:21 tests/
    $ /v/d/w/simpleblog (master)> git add --all
    $ /v/d/w/simpleblog (master)> git status
    $ /v/d/w/simpleblog (master)> git commit -m "Initial Commit"
    $ /v/d/w/simpleblog (master)> git push -u origin master

Then enjoy the gitlab pipeline!