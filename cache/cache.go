package cache

import (
	"errors"
	"fmt"
	"time"

	"github.com/go-redis/redis"
)

type CacheService struct {
	client *redis.Client
}

var (
	cacheService = &CacheService{}
)

const redisAddr = "localhost:6379"
const cacheDuation = 6 * time.Hour

func InitializeCacheService() *CacheService {
	redisClient := redis.NewClient(&redis.Options{
		Addr:     redisAddr,
		Password: "",
		DB:       0,
	})
	pong, err := redisClient.Ping().Result()
	if err != nil {
		fmt.Printf("Error initializaing Redis Client %v", err)
		return nil
	}
	fmt.Printf("Redis Client Initialized Successfully! %v\n", pong)
	cacheService.client = redisClient
	return cacheService
}

func IsPresentInCache(url string) bool {
	_, err := cacheService.client.Get(url).Result()
	return err == nil
}

func SaveUrlMapping(originalUrl string, shortUrl string) error {
	err := cacheService.client.Set(shortUrl, originalUrl, cacheDuation).Err()
	if err != nil {
		return errors.New("error saving key-value to redis")
	}
	fmt.Printf("Saveed key-value %v - %v\n", shortUrl, originalUrl)
	return nil
}

func RetrieveOriginalUrl(shortUrl string) (string, error) {
	if !IsPresentInCache(shortUrl) {
		return "", errors.New("404: key not found")
	}
	val, err := cacheService.client.Get(shortUrl).Result()
	if err != nil {
		return "", errors.New("unknown error occured when retrieving original url")
	}
	return val, nil
}
