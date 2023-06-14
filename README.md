## Nextcloud Docker Setup

This repository contains a Docker Compose configuration for setting up a Nextcloud instance with MariaDB, Redis, and a cron job.

### docker-compose.yml

This file defines the services that make up our Nextcloud environment:

#### db

* Uses the official MariaDB image (`mariadb:latest`).
* Automatically restarts on failure (`restart: always`).
* Mounts the local `./mysql/` directory to the container's `/var/lib/mysql/`, persisting database data.
* Sets environment variables for the MariaDB root password (`MYSQL_ROOT_PASSWORD`), user password (`MYSQL_PASSWORD`), database name (`MYSQL_DATABASE`), and username (`MYSQL_USER`).

#### app

* Uses the official Nextcloud image (`nextcloud:latest`).
* Exposes port 80 on the host machine (`ports: - ${PORT}:80`).
* Links to the `db` service to connect to the MariaDB database.
* Mounts the local `./html/` directory to the container's `/var/www/html/`, hosting the Nextcloud files.
* Automatically restarts on failure (`restart: always`).
* Depends on the `db`, `redis`, and `cron` services.

#### cron

* Uses the official Nextcloud image (`nextcloud:latest`).
* Automatically restarts on failure (`restart: always`).
* Mounts the local `./html/` directory to the container's `/var/www/html/`.
* Runs `/cron.sh` as the entrypoint, executing scheduled tasks.
* Depends on the `db` service.

#### redis

* Uses the official Redis image.
* Mounts the local `./redis/` directory to the container's `/data/`, persisting Redis data.

### Running the setup

1. Ensure you have Docker Compose installed.
2. Replace the placeholder environment variables (`MYSQL_ROOT_PASSWORD`, `MYSQL_PASSWORD`, etc.) with your desired values.
3. Run `docker-compose up -d` to start the containers.
4. Access Nextcloud at `http://localhost:${PORT}`.

## License

This project is licensed under the [MIT License](LICENSE).

