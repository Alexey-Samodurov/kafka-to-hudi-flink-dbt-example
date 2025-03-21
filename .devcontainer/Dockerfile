FROM python:3.10-slim

USER root

COPY ../requirements.txt requirements.txt

RUN pip3 install -qr requirements.txt

RUN mkdir /root/.dbt

WORKDIR /workspace
