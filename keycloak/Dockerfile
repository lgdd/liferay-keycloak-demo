ARG BASE_IMAGE=quay.io/keycloak/keycloak:21.1.1

FROM ${BASE_IMAGE} AS builder

ENV KC_DB=mysql

# Install custom providers
ADD --chown=keycloak:keycloak https://github.com/aerogear/keycloak-metrics-spi/releases/download/3.0.0/keycloak-metrics-spi-3.0.0.jar /opt/keycloak/providers/keycloak-metrics-spi-3.0.0.jar
RUN /opt/keycloak/bin/kc.sh build --health-enabled=true --metrics-enabled=true --features=token-exchange,docker

FROM ${BASE_IMAGE}
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
# change these values to point to a running postgres instance
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
