postgres:
	docker run --name postgres-local -e POSTGRES_PASSWORD=root -d -p 5432:5432 postgres:17-alpine

createdb:
	docker exec -it postgres-local createdb --username=postgres --owner=postgres goingmysimplebank

dropdb:
	docker exec -it postgres-local dropdb --if-exists goingmysimplebank

migrateup:
	migrate -path db/migrations -database "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server