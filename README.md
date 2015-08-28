Grape API on Rack
=================

[![Build Status](https://travis-ci.org/ruby-grape/grape-on-rack.svg?branch=master)](https://travis-ci.org/ruby-grape/grape-on-rack)
[![Dependency Status](https://gemnasium.com/ruby-grape/grape-on-rack.svg)](https://gemnasium.com/ruby-grape/grape-on-rack)
[![Code Climate](https://codeclimate.com/github/ruby-grape/grape-on-rack.svg)](https://codeclimate.com/github/ruby-grape/grape-on-rack)

A [Grape](http://github.com/ruby-grape/grape) API mounted on Rack.

* [ping](api/ping.rb): a hello world example that returns a JSON document
* [post_put](api/post_put.rb): a simple `POST` and `PUT` example
* [post_json](api/post_json.rb): an example that shows a `POST` of JSON data
* [get_json](api/get_json.rb): an example that pre-processes params sent as JSON data
* [rescue_from](api/rescue_from.rb): an example of `rescue_from` that wraps all exceptions in an HTTP error code 500
* [path_versioning](api/path_versioning.rb): an example that uses path-based versioning
* [header_versioning](api/header_versioning.rb): an example that uses vendor header-based versioning
* [wrap_response](api/wrap_response.rb): a middleware that wraps all responses and always returns HTTP code 200
* [content_type](api/content_type.rb): an example that overrides the default `Content-Type` or returns data in both JSON and XML formats
* [upload_file](api/upload_file.rb): an example that demonstrates a file upload and download
* [entites](api/entities.rb): an example of using [grape-entity](https://github.com/ruby-grape/grape-entity)

See
---

There's a deployed [grape-on-rack on Heroku](http://grape-on-rack.herokuapp.com/).

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

### Hello World

Navigate to http://localhost:9292/api/ping with a browser or use `curl`.

```
$ curl http://localhost:9292/api/ping

{"ping":"pong"}
```

### Get Plain Text

```
$ curl http://localhost:9292/api/plain_text

A red brown fox jumped over the road.
```

### Upload a File

```
$ curl -X POST -i -F image_file=@spec/fixtures/grape_logo.png http://localhost:9292/api/avatar

{"filename":"grape_logo.png","size":4272}
```

### Upload and Download a File

```
$ curl -X POST -i -F file=@spec/fixtures/grape_logo.png http://localhost:9292/api/download.png
$ curl -X POST -i -F file=@api/ping.rb http://localhost:9292/api/download.rb
```

List Routes
-----------

```
rake routes
```

Explore the API
---------------

Explore the API using [Swagger UI](http://petstore.swagger.io). Run the application and point the explorer to `http://localhost:9292/api/swagger_doc` or `http://grape-on-rack.herokuapp.com/api/swagger_doc`.

New Relic
---------

The application is setup with NewRelic w/ Developer Mode. Navigate to http://localhost:9292/newrelic after making some API calls.
