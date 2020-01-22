FROM python:3.7-alpine

ENV PATH /app/bin:/app/.local/bin:$PATH
ENV FLASK_APP=simpleblog
ENV FLASK_ENV=development

LABEL maintainer="Francois Colombo <francois_colombo@yahoo.fr>"

RUN addgroup -g 1000 -S simpleblog && \
    adduser -u 1000 -S simpleblog -G simpleblog -h /app

USER simpleblog

RUN mkdir -p /app/simpleblog

COPY simpleblog /app/simpleblog/
COPY setup.* /app/

RUN pip3 install --user --no-cache-dir --upgrade pip setuptools wheel virtualenv && \
    cd /app && \
    virtualenv /app && \
    pip install --no-cache-dir --upgrade Flask wheel pytest coverage waitress && \
    flask init-db && \
    pip install -e . && \
    python setup.py install

WORKDIR /app

EXPOSE 8071
