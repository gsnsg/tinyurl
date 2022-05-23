package main

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func handleStartPath(c *gin.Context) {
	c.JSON(http.StatusOK, "Hello Url Shortener!")
}

func main() {

	fmt.Println("Firing up server....")
}
