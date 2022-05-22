package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/gsnsg/tinyurl-go/cache"
)

func handleStartPath(c *gin.Context) {
	c.JSON(http.StatusOK, "Hello Url Shortener!")
}

func main() {
	cache.InitializeCacheService()
}
