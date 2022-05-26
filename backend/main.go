package main

import (
	"github.com/gin-gonic/gin"
	"github.com/gsnsg/tinyurl-go/cache"
	"github.com/gsnsg/tinyurl-go/dbservice"
	"github.com/gsnsg/tinyurl-go/handler"
)

func main() {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "Welcome to url shortener API 🚀",
		})
	})

	r.POST("/create-short-url", func(c *gin.Context) {
		handler.CreateShortUrl(c)
	})

	r.GET("/re/:shortUrl", func(c *gin.Context) {
		handler.HandleShortUrlRedirect(c)
	})

	dbservice.InitializeDB()
	cache.InitializeCacheService()

	err := r.Run(":9098")

	if err != nil {
		panic(err.Error())
	}
}
