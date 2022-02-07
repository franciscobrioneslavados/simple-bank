postgres-docker:
	docker run --name postgres12-alpine -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=postgres -d postgres:12-alpine
createdb:
	docker exec -it postgres12-alpine createdb --username=root --owner=root simple_bank
dropdb: 
	docker exec -it postgres12-alpine dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up
migrateup1:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up 1
migrateup2:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up 2
migratedown: 
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down
migratedown1: 
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down 1
migratedown2: 
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down 2
sqlc: 
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/franciscobrioneslavados/simple-bank/db/sqlc Store
.PHONY: postgres-docker createdb dropdb migrateup migratedown migrateup1 migratedown1 migrateup2 migratedown2 sqlc test server mock