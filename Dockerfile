FROM python:3.12-bookworm

LABEL maintainer "Peter Grønbæk Andersen <peter@grnbk.io>"

RUN printf "deb http://httpredir.debian.org/debian sid main non-free\ndeb-src http://httpredir.debian.org/debian sid main non-free" > /etc/apt/sources.list.d/backports.list
RUN apt update
RUN apt -t sid -y install postgresql-client-15

RUN pip install --upgrade pip
RUN pip install psycopg2
RUN pip install poetry

USER root

ENTRYPOINT ["/bin/bash"]

CMD ["-c"]
