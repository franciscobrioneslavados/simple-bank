# simple-bank
Project in GO following the UDEMY course [Backend Master Class [Golang + PostgreSQL + Kubernetes]](https://www.udemy.com/course/backend-master-class-golang-postgresql-kubernetes/)

[Github Repo Course](https://github.com/techschool/simplebank)

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
* exec image with /bin/sh
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
## Choose the correct ORM
![TTC](images/TTC.png?raw=true "TTC")
* [GORM](https://gorm.io/index.html)
* [SQLX](https://github.com/jmoiron/sqlx)
* [SQLC](https://github.com/kyleconroy/sqlc)

### [Transacion Isolation Levels](./isolation-levels/README.md)

## Choose the correct Go Framework & HTTP Routers
![WW](images/PW.png?raw=true "PW")


## Mock Databae wint mockgen
```
mockgen -package mockdb -destination db/mock/store.go  github.com/franciscobrioneslavados/simple-bank/db/sqlc Store
```


## Docker
* Build
```
docker build -t simplebank:latest .   
```
* Create a docker Networ to joun booth images [psql|golang]
```
docker network create bank-network
```
* Connect postgres image to bank network
```
docker network connect bank-network postgres12-alpine
```
* Run
```
docker run --name simplebank --network bank-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:postgres@postgres12-alpine:5432/simple_bank?sslmode=disable" simplebank:latest
```
* network inspect
```
docker network inspect bank-network
result-like: 
"Containers": {
            "bb00cdb8bbf57076ca4de4e14ff6480468867df6e04f0b5f208a21d31dc35152": {
                "Name": "postgres12-alpine",
                "EndpointID": "80c448c62f1c9a793397176f158beb34d5036996d82f683d8d822dc0ea0df0bf",
                "MacAddress": "02:42:ac:14:00:02",
                "IPv4Address": "172.20.0.2/16",
                "IPv6Address": ""
            },
            "dd2af5167efa181faa720020e7a195dc31f86f9056acda273f12e0f7fa115de3": {
                "Name": "simplebank",
                "EndpointID": "d642ab8da9671b84a796cda9be0bd687112355ed5e7f01e41484dad280ae449c",
                "MacAddress": "02:42:ac:14:00:03",
                "IPv4Address": "172.20.0.3/16",
                "IPv6Address": ""
            }
        },
```
* Remove "none" images (BONUS)
``` 
docker rmi $(docker images --filter “dangling=true” -q --no-trunc)
```

## Secrets
* Generate a random 32 bits to token symmentric key
```
openssl rand -hex 64 | head -c 32
```

## AWS
* Login to ECR
```
aws ecr get-login-password | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```
