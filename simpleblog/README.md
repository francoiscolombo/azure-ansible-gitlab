# simpleblog

this is a very simple Flask application, which is basically the one you can find from the official tutorial.

however, this one can be managed by docker containers.

## using docker with simpleblog

### build the docker image

that's easy, simply enter the docker build command as follow:

    $ docker build -t keyteo/simpleblog .

### run the tests

you need to have the image built, obviously. then run the following command:

    $ docker run -t -v /var/data/workspaces/azure-ansible-gitlab/simpleblog/tests:/app/tests keyteo/simpleblog sh -c ". bin/activate && pip install -e . && coverage run -m pytest && coverage report"

basically, you ask to execute the following commands inside you container:

    $ . bin/activate
    $ pip install -e .
    $ coverage run -m pytest
    $ coverage report

the first one activate you virtual env. 
the second one install your module onto this virtual env.
the third one run your unit tests, and calculate the code coverage
the last one simply show a report with the executed tests.

### start your server

once again, you need to have your image built. run the following command:

    $ docker run -p 8071:8071 -t keyteo/simpleblog sh -c ". bin/activate && pip install -e . && flask init-db && waitress-serve --url-scheme=http --listen=0.0.0.0:8071 --no-ipv6 --call simpleblog:create_app"

whoa that's a big command! but it's quite easy to understand. you basically ask to activate your virtual env, install the flask application, initialize the database and finally launch waitress on the port 8071 to serve your flask application. and since you are using the port 8071 on the container, then we need to report it to be open on the host itself with the `-p 8071:8071` parameter. easy, no?

## gitlab

you have also a file, named `.gitlab-ci.yml` present under the project. this file allows you to activate the CI/CD features of Gitlab CE, and so build / test / deploy your application after every commit, which allows Gitlab to mark your commit as successfull or not.

the file contains 3 stages:

- build
- test
- deploy

every single stage just run a docker command, and do some cleaning if it's needed.