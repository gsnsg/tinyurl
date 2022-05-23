package dbservice

import (
	"database/sql"
	"fmt"

	"github.com/gsnsg/tinyurl-go/constants"
	_ "github.com/lib/pq"
)

type DBService struct {
	db *sql.DB
}

var dbService = &DBService{}

func checkError(err error) {
	if err != nil {
		panic(err.Error())
	}
}

func InitializeDB() *sql.DB {
	dbInfo := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable", constants.DB_USER, constants.DB_PASSWORD, constants.DB_NAME)
	db, err := sql.Open("postgres", dbInfo)
	checkError(err)
	fmt.Println("DB Initialized")
	dbService.db = db
	return db
}

func GetOriginalUrl(shortUrl string) (string, error) {
	dbQuery := "SELECT long_url FROM urls WHERE short_url = $1;"
	fmt.Printf("Executing Query : %s\n", dbQuery)
	var originalUrl string
	err := dbService.db.QueryRow(dbQuery, shortUrl).Scan(&originalUrl)
	if err != nil {
		return "", err
	}
	return originalUrl, nil
}

func InsertUrl(shortUrl string, longUrl string) error {
	dbQuery := fmt.Sprintf("INSERT INTO urls (short_url, long_url) VALUES ('%s', '%s');", shortUrl, longUrl)
	_, err := dbService.db.Exec(dbQuery)
	if err != nil {
		return err
	}
	return nil
}

func TruncateDB() {
	dbQuery := "TRUNCATE urls;"
	_, err := dbService.db.Exec(dbQuery)
	checkError(err)
}
