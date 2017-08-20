# debian-bamboo
Dockerized bamboo service, built on top of official Debian images.

## Supported tags and respective Dockerfile links

| Product |Version | Tags  | Dockerfile |
|---------|--------|-------|------------|
| Bamboo Software | 6.1.1 | v6.1.1, latest | [Dockerfile](https://github.com/thinegan/debian-bamboo/blob/master/Dockerfile) |

# Installed packages
* Debian GNU/Linux 9 (Stretch) x64bit
* Oracle Java 8 
* mysql-connector-java - v5.1.43
* Atlassian Bamboo - v6.1.1

# Config:
* Dependencies Package:
  * software-properties-common
  * gnupg 
  * curl
  * wget
  * xmlstarlet

# Shortcut
Docker-Compose:
```console
$ curl -O https://raw.githubusercontent.com/thinegan/debian-bamboo/master/docker-compose.yml
$ docker-compose pull && docker-compose up -d
```

# Docker-CLI:
```console
$ docker run -d -p 8000:8085 \
-v /home/user/bamboo-data:/home/www/public_html/bamboo-data.server.com \
--name bamboo thinegan/debian-bamboo:v6.1.1
```

# More Info:
* Bamboo will be available at http://yourdockerhost:8000.
* Data will be persisted inside docker volume `bamboo-data`.
* host path : /home/user/bamboo-data
* container path : /home/www/public_html/bamboo-data.server.com
* you can use mysql from endpoint connection
* exposed port 8085
* default command: bamboo start

# Example:
![example-docker-bamboo](https://github.com/thinegan/debian-bamboo/raw/master/images/example-bamboo-start.png)

# Issues
If you run into any problems with this image, please check (and potentially file new) issues on the [thinegan/debian-bamboo](https://github.com/thinegan/debian-bamboo) repo, which is the source for this image.

# References
* [Atlassian Bamboo](https://www.atlassian.com/software/bamboo)
* [Docker Homepage](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker Userguide](https://docs.docker.com/userguide/)
* [Oracle Java](https://java.com/en/download/)