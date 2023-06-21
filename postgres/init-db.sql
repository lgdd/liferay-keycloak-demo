create role keycloak with
  login
  nosuperuser
  inherit
  nocreatedb
  nocreaterole
  noreplication
  encrypted password 'keycloak';
create schema keycloak authorization keycloak;

create role "liferay" with
  login
  nosuperuser
  inherit
  nocreatedb
  nocreaterole
  noreplication
  encrypted password 'liferay';
create schema "liferay" authorization "liferay";
