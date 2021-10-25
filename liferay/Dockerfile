ARG BASE_IMAGE=liferay/dxp:7.3.10-dxp-2
FROM ${BASE_IMAGE}

USER root

RUN apt update && \
    apt install -y netcat && \
    apt clean

USER liferay:liferay

ADD --chown=liferay:liferay https://raw.githubusercontent.com/eficode/wait-for/master/wait-for /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for
