**Домашнее задание 9**

1. Скачал репозиторий https://github.com/aeuge/otus-mysql-docker
2. Добавил скрипт инициализации БД init.sql
3. Добавил параметры conf.d/my.cnf
4. Запустил докер-компоуз  docker-compose  up -d  otusdb
root@kisuss-db-1:/home/sadmin/mysql_docker# docker ps

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
d36be469e798   mysql:8.0.15   "docker-entrypoint.s…"   15 minutes ago   Up 13 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql_docker_otusdb_1

 