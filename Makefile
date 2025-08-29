postgres:
	docker run --name postgres-local -e POSTGRES_PASSWORD=root -d -p 5432:5432 postgres:17-alpine

createdb:
	docker exec -it postgres-local createdb --username=postgres --owner=postgres goingmysimplebank

dropdb:
	docker exec -it postgres-local dropdb --if-exists goingmysimplebank

migrateup:
	migrate -path db/migrations -database "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migrations -database "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migrations -database "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migrations -database "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -destination db/mock/store.go -package mockdb goingmysimplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock