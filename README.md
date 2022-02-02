# simple-bank
Project in GO following the UDEMY course

### Docker commands
* pull postgres image
```
docker pull postgres:12-alpine
```
* run image
```
docker run --name postgres12-alpine -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=postgres -d postgres:12-alpine
```
* exec image
```
docker exec -it postgres12-alpine psql -U postgres
```
* exec image witn /bin/sh
```
docker exec -it postgres12-alpine /bin/sh
```
* exec image and conect to database
```
docker exec -it postgres12-alpine psql -U root -d simple_bank
```
* logs image
```
docker logs postgres12-alpine
```


### Install [Golang Migrate CLI](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate)
#### migrate commnads
* create 
``` 
migrate create -ext sql -dir db/migration -seq init_schema
```

### Makefile to easy share with a development team
```
make <command_in_list_Makefile>
```

### Things to Considerate
#### choose the correct ORM
![TTC](images/TTC.png?raw=true "TTC")
* [GORM](https://gorm.io/index.html)
* [SQLX](https://github.com/jmoiron/sqlx)
* [SQLC](https://github.com/kyleconroy/sqlc)

### [Transacion Isolation Levels](./isolation-levels/README.md)