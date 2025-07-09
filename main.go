package main

import (
	"database/sql"
	"goingmysimplebank/api"
	db "goingmysimplebank/db/sqlc"
	"log"

	_ "github.com/lib/pq" // PostgreSQL driver
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://postgres:root@localhost:5432/goingmysimplebank?sslmode=disable"
	address  = "0.0.0.0:8080"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(address)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
