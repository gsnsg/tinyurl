# tinyurl-go

### Backend
1. Redis for Caching
2. PostgresSQL for storing URL mappings

### Client
1. SwiftUI for the app
2. CoreData to store url mappings locally on client side

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
User can generate the short links and also can view past links they have shortened
## Screenshots 📷

Home Page |       History Tab  
:-------------------------:|:-------------------------:| 
<img src="imgs/ss_1.png" width="250" height="550" />|<img src="imgs/ss_2.png" width="250" height="550" />

https://user-images.githubusercontent.com/17419092/170525820-9004d82c-d542-4040-8dd6-63db1507b851.mp4

## Author
* [Sai Nikhit Gulla](https://github.com/gsnsg)


#### References: [Building an URL shortener in Go](https://www.eddywm.com/lets-build-a-url-shortener-in-go-part-iv-forwarding/)

