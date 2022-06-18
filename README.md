Grape API on Rack
=================

[![Test](https://github.com/ruby-grape/grape-on-rack/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/ruby-grape/grape-on-rack/actions/workflows/test.yml)
[![Code Climate](https://codeclimate.com/github/ruby-grape/grape-on-rack.svg)](https://codeclimate.com/github/ruby-grape/grape-on-rack)

A [Grape](http://github.com/ruby-grape/grape) API mounted on Rack.

Run
---

```
$ bundle install
$ rackup

Loading NewRelic in developer mode ...
[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

List Routes
-----------

```
rake routes
```

Explore the API
---------------

Explore the API using [Swagger UI](http://petstore.swagger.io). Run the application and point the explorer to `http://localhost:9292/api/swagger_doc` or `http://grape-on-rack.herokuapp.com/api/swagger_doc`.


## Examples
### [ping](api/ping.rb)

A hello world example that returns a JSON document.

```
$ curl http://localhost:9292/api/ping

{"ping":"pong"}
```

### [post_put](api/post_put.rb)

A simple `POST` and `PUT` example.

```
curl -XPOST -d '' http://localhost:9292/api/ring 

{"rang":7}
```

```
curl -XPUT -d '{"count":2}' -H "Content-Type:application/json" http://localhost:9292/api/ring 

{"rang":9}
```

### [post_json](api/post_json.rb)

An example that shows a `POST` of JSON data.

```
$ curl -XPOST http://localhost:9292/api/spline -d '{"reticulated":"lots"}' -H "Content-Type:application/json"

{"reticulated":"lots"}
```

### [get_json](api/get_json.rb)

An example that pre-processes params sent as JSON data.

```
$ curl http://localhost:9292/api/reticulated_splines?splines=[{"id":1,"reticulated":true},{"id":2,"reticulated":false}]

[{"id":1,"reticulated":false},{"id":2,"reticulated":true}]
```

### [rescue_from](api/rescue_from.rb)

An example of `rescue_from` that wraps all exceptions in an HTTP error code 500.

```
$ curl -i http://localhost:9292/api/raise
HTTP/1.1 500 Internal Server Error
Last-Modified: Wed, 15 Jun 2022 01:12:37 GMT
Content-Type: text/html
Content-Length: 234
Vary: Origin
Server: WEBrick/1.4.2 (Ruby/2.6.5/2019-10-01)
Date: Sat, 18 Jun 2022 01:51:25 GMT
Connection: Keep-Alive

<html>
 <head>
  <title>Unexpected Error</title>
</head>
 <body>
  <h1>Ouch...</h1>
  <a href="http://rack.rubyforge.org/">
   <img src="/images/rack-logo.png">
  </a>
  <p>
    Something went terribly wrong.
  </p>
 </body>
</html>
```

### [path_versioning](api/path_versioning.rb)

An example that uses path-based versioning.

```
$ curl http://localhost:9292/api/vendor

{"path":"acme"}
```

### [header_versioning](api/header_versioning.rb)

An example that uses vendor header-based versioning.

```
$ curl -H "Accept:application/vnd.acme-v1+json" http://localhost:9292/api

{"header":"acme"}
```
### [wrap_response](api/wrap_response.rb)

A middleware that wraps all responses and always returns HTTP code 200.

```
$ curl http://localhost:9292/api/decorated/ping

{"body":{"ping":"pong"},"status":200}
```

### [content_type](api/content_type.rb)

An example that overrides the default `Content-Type` or returns data in both JSON and XML formats.

```
$ curl http://localhost:9292/api/plain_text

A red brown fox jumped over the road.
```

```
$ curl http://localhost:9292/api/mixed

{"data":"A red brown fox jumped over the road."}
```

```
$ curl http://localhost:9292/api/mixed.xml

<?xml version="1.0" encoding="UTF-8"?>
<hash>
  <data>A red brown fox jumped over the road.</data>
</hash>
```

### [upload_file](api/upload_file.rb)

An example that demonstrates a file upload and download.

```
$ curl -X POST -i -F image_file=@spec/fixtures/grape_logo.png http://localhost:9292/api/avatar

{"filename":"grape_logo.png","size":4272}
```

```
$ curl -X POST -i -F file=@spec/fixtures/grape_logo.png http://localhost:9292/api/download.png

HTTP/1.1 201 Created
Content-Type: image/png
Content-Disposition: attachment; filename*=UTF-8''grape_logo.png
Vary: Origin
Content-Length: 4272
Server: WEBrick/1.4.2 (Ruby/2.6.5/2019-10-01)
Date: Sat, 18 Jun 2022 02:12:21 GMT
Connection: Keep-Alive
```

```
$ curl -X POST -i -F file=@api/ping.rb http://localhost:9292/api/download.rb

HTTP/1.1 201 Created
Content-Type: application/x-ruby
Content-Disposition: attachment; filename*=UTF-8''ping.rb
Vary: Origin
Content-Length: 115
Server: WEBrick/1.4.2 (Ruby/2.6.5/2019-10-01)
Date: Sat, 18 Jun 2022 02:12:47 GMT
Connection: Keep-Alive

module Acme
  class Ping < Grape::API
    format :json
    get '/ping' do
      { ping: 'pong' }
    end
  end
end
```

### [entites](api/entities.rb)

An example of using [grape-entity](https://github.com/ruby-grape/grape-entity).

```
$ curl http://localhost:9292/api/entities/1

{"tool":{"id":"1","length":10,"weight":"20kg"}}
```

### [headers](api/headers.rb)

Demonstrates header case-sensitive handling.

```
$ curl http://localhost:9292/api/headers/Host

{"Host":"localhost:9292"}
```

See Also
--------

There's a deployed [grape-on-rack on Heroku](http://grape-on-rack.herokuapp.com/).

New Relic
---------

The application is setup with NewRelic w/ Developer Mode. Navigate to http://localhost:9292/newrelic after making some API calls.
