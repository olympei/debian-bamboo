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
