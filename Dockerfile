FROM quay.io/keycloak/keycloak:24.0.1 as builder

COPY lifeapps-theme/ /opt/keycloak/themes/lifeapps-theme/

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres
WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:24.0.1
COPY --chown=keycloak:keycloak --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]