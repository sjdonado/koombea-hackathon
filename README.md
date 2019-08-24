## Run
```
 docker-compose up
```
## Migration
```
  docker-compose run --rm api rails db:migrate
```
## Style guide verification
```
 docker-compose run --rm api rubocop
```
## Docs
* Postman collection: ./docs/koomnbea-hackathon.postman_collection.json