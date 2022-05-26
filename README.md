# tinyurl-go

### Backend
1. Redis for Caching
2. PostgresSQL for storing URL mappings

### Client
1. SwiftUI for the app
2. CoreData to store url mappings locally

### API Endpoints
- #### `/create-short-url`, which is a `POST` request validates and creates a short url from long url and user id passed to it

```
curl --location --request POST 'http://localhost:9098/create-short-url' \
--header 'Content-Type: text/plain' \
--data-raw '{
    "long_url": "https://amazon.com",
    "user_id" : "e0dba740-fc4b-497872c-d360239e"
}
'
```

Sample Response (200 Status Code):
```
{
    "message": "short url created successfully",
    "short_url": "http://localhost:9098/re/SwwSgzBe"
}
```

- #### `/re/:shortUrl`, which is a `GET` request redirecting to the `shortUrl` mapping present in DB/Cache



#### Client Side 
## Screenshots 📷

<img src="imags/Simulator Screen Shot - iPhone 12 - 2022-05-26 at 20.18.21.png" />
<img src="images/ss2.jpg" />


## Author
* [Sai Nikhit Gulla](https://github.com/gsnsg)

#### References: [Building an URL shortener in Go](https://www.eddywm.com/lets-build-a-url-shortener-in-go-part-iv-forwarding/)

