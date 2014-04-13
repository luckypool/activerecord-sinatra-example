README.md
=========

ActiveRecord を理解するために作られた Sinatra アプリです。

Userモデルに対応する CRUD をAPIで操作できます


## Prepare

### bundle install


```
$ bundle install
```


### migrate 

```
$ rake db:migrate
$ rake db:test:prepare
```

### spec

```
$ rake
```

## Run server

### rackup

```
$ bundle exec rackup
```

then, server will start (port=9292)

### CRUD via API

endpoint : `/users`


#### Create user

```
$ curl -i -X POST http://localhost:9292/users \
-H 'Content-Type:application/json' \
-d '{"name":"fooBar", "birthday":"1999-07-01"}' \

HTTP/1.1 201 Created
Content-Type: application/json
Content-Length: 128
X-Content-Type-Options: nosniff
Server: WEBrick/1.3.1 (Ruby/2.1.0/2013-12-25)
Date: Sun, 13 Apr 2014 15:04:14 GMT
Connection: Keep-Alive

{"id":1,"name":"fooBar","birthday":"1999-07-01","created_at":"2014-04-13T15:04:14.128Z","updated_at":"2014-04-13T15:04:14.128Z"}
```

#### Read users

```
$ curl -i -X GET http://localhost:9292/users \

HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 130
X-Content-Type-Options: nosniff
Server: WEBrick/1.3.1 (Ruby/2.1.0/2013-12-25)
Date: Sun, 13 Apr 2014 15:05:19 GMT
Connection: Keep-Alive

[{"id":1,"name":"fooBar","birthday":"1999-07-01","created_at":"2014-04-13T15:04:14.128Z","updated_at":"2014-04-13T15:04:14.128Z"}]
```

#### Read user

```
$ curl -i -X GET http://localhost:9292/users/1 \

HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 128
X-Content-Type-Options: nosniff
Server: WEBrick/1.3.1 (Ruby/2.1.0/2013-12-25)
Date: Sun, 13 Apr 2014 15:07:38 GMT
Connection: Keep-Alive

{"id":1,"name":"fooBar","birthday":"1999-07-01","created_at":"2014-04-13T15:04:14.128Z","updated_at":"2014-04-13T15:04:14.128Z"}
```

#### Update user

```
$ curl -i -X PUT http://localhost:9292/users/1 \
-H 'Content-Type:application/json' \
-d '{"name":"HogeFuga", "birthday":"1999-06-01"}' \

HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 130
X-Content-Type-Options: nosniff
Server: WEBrick/1.3.1 (Ruby/2.1.0/2013-12-25)
Date: Sun, 13 Apr 2014 15:09:58 GMT
Connection: Keep-Alive

{"id":1,"name":"HogeFuga","birthday":"1999-06-01","created_at":"2014-04-13T15:04:14.128Z","updated_at":"2014-04-13T15:09:58.482Z"}
```

#### Delete user

```
$ curl -i -X DELETE http://localhost:9292/users/1 \

HTTP/1.1 204 No Content
X-Content-Type-Options: nosniff
Server: WEBrick/1.3.1 (Ruby/2.1.0/2013-12-25)
Date: Sun, 13 Apr 2014 15:11:40 GMT
Connection: Keep-Alive

```
