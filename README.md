# CiviHR-Docker

Steps to RUN
1. `docker-compose up -d db` //Its is necessary to run DB first as 'web' needs 'db' to build itself
2. `docker-compose build` // Here only 'web' will get built
3. `docker-compose up -d web` //Start 'web'

By this point the CiviHR should be accessible in the browser on the following URL

[http://localhost:8908](http://localhost:8908)

PS. Its not working now.
