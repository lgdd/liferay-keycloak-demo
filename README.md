# Liferay Keycloak Demo

A pre-configured Docker Compose environment to demonstrate how to use Single Sign-On (SSO) on Liferay 7.4.13 U55 using Keycloak as an OpenID Connect Provider (OIDC).

## Requirements

- Docker 19+

## Change Log

`4th April 2024`

- Updated Liferay version to Liferay 7.4.13 U112

`21th December 2020`

- Updated Liferay version to Liferay 7.4.13 U55 and added `netcat` to the image.

- The jboss/keycloak image does not seem to work on the Apple M1 chip, so this has been substituted with the quay.io/keycloak/keycloak image instead. This has lead to some configuration changes as well.

- The client secret can no longer be null / unset. This has been updated to be `liferay`. You can change this value to what ever you wish in the osgi/configs files.

- Updated keycloak configuration to reflect changes, i.e. OpenID Connect Urls and the environment variables for the initial admin account.

## Setup

Because Liferay communicate in the backend with Keycloak and also redirect the end user to it, you need to align hostname and port between Docker Compose and your host.
Thus, with this default configuration, you need to add `sso` as possible host from your localhost in `/etc/hosts` and be sure that the port `8080` is available.

If you want to test this setup with other Liferay editions / versions, you can change the Liferay base image in `docker-compose.yml`.

## Access

- Liferay: http://localhost
- Keycloak: http://sso:8080
- SMTP: http://localhost:5000

## Start up scenario

- Run `docker-compose up`
- When everything is ready, go http://localhost
- Click on `Sign in`, then `OpenID Connect` and `Sign in` again where you should see `Keycloak` as the only `OpenId Connect Provider Name` in the list.
- You should be redirected to http://sso:8080 (with more parameters, of course)
- Click `Register` to add a new user
- Fill out the form and save
- You should be redirected to Liferay where you're asked to verify your email
- Go to http://localhost:5000 and check for new messages
- You should have received the confirmation code
- Copy the code and past it on Liferay
- Now you should be logged in as your new user

## FAQ

### How do I access Keycloak admin console?
Go to http://sso:8080 and use the default credentials `admin`:`admin`.

### Can I map roles from Keycloak to Liferay?
You can do it through some development. You'll find an example and more information about this in [this repository](https://github.com/fabian-bouche-liferay/oidc-userinfo-mapping).

### Can I have a single button to connect to Keycloak?

Yes, you could use a Fragment such as this one: https://github.com/lgdd/openid-connect-single-button.

### Why can't I reach the database from my localhost?
By default, in `docker-compose.yml`, the port has not been forwarded to localhost. So you have to update the file, and do something like:
```
  db:
    image: mysql:8
    ports:
      - "3306:3306"
```
> Number on the left is the one you're forwarding to your localhost, so make sure it's not already taken and if so, choose another one.

### Why am I seeing the address already in use for port `5000`?

Since macOS Monterey, port `5000` is used by Content Center, more specially by a AirPlay Receiver.

Either disable the AirPlay Receiver via the System Preferences or change the port defined in the docker compose file for smtp4dev to another port, for example `5050`.

## License

[MIT](LICENSE)