postgres-docker:
	docker run --name postgres12-alpine -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=postgres -d postgres:12-alpine
createdb:
	docker exec -it postgres12-alpine createdb --username=root --owner=root simple_bank
dropdb: 
	docker exec -it postgres12-alpine dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up
migratedown: 
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down
sqlc: 
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/franciscobrioneslavados/simple-bank/db/sqlc Store
.PHONY: postgres-docker createdb dropdb migrateup migratedown sqlc test server mock