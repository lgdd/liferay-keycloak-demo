ARG BASE_IMAGE=liferay/portal:7.4.3.112-ga112
FROM ${BASE_IMAGE}

USER root
RUN apt-get update && apt-get install -y netcat
USER 1000

ADD --chown=liferay:liferay https://raw.githubusercontent.com/eficode/wait-for/master/wait-for /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for
