FROM ubuntu:latest
LABEL authors="studac"

ENTRYPOINT ["top", "-b"]