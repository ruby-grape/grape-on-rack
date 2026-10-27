# Grape on Rack

[![Test](https://github.com/ruby-grape/grape-on-rack/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/ruby-grape/grape-on-rack/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/ruby-grape/grape-on-rack/badge.svg?branch=master)](https://coveralls.io/github/ruby-grape/grape-on-rack?branch=master)

A [Grape](https://github.com/ruby-grape/grape) API mounted on Rack.

Tests
-----

GitHub Actions tests the latest Rack 2.2 and 3.x releases on Ruby 3.3, Rack 3.x on Ruby 3.4, and the newest Rack release on Ruby 4.0. Matrix jobs resolve dependencies independently of the application lockfile so new compatible releases are exercised. Run `bundle exec rake spec` locally, or select a different Rack line with `RACK_VERSION='~> 2.2' bundle update` followed by `RACK_VERSION='~> 2.2' bundle exec rake spec`. Browser examples require Firefox; use `MOZ_HEADLESS=1 bundle exec rake spec` to run them without a display. Run `bundle exec rubocop` for lint.

SimpleCov starts before the application loads. CI uploads `coverage/lcov.info` from each matrix job to Coveralls and finishes the parallel coverage build after all jobs pass.

Run
---

```
$ bundle install
$ bundle exec rackup
```

Use Ruby 3.3 or newer with the default bundle. The application listens at http://localhost:9292.

List Routes
-----------

```
bundle exec rake routes
```

Explore the API
---------------

Explore the API using [Swagger UI](https://github.com/swagger-api/swagger-ui). Run the application and navigate to [http://localhost:9292/swagger/index.html](http://localhost:9292/swagger/index.html).

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
$ curl --get --data-urlencode 'splines=[{"id":1,"reticulated":true},{"id":2,"reticulated":false}]' http://localhost:9292/api/reticulated_splines

[{"id":1,"reticulated":false},{"id":2,"reticulated":true}]
```

### [rescue_from](api/rescue_from.rb)

An example of `rescue_from` that wraps all exceptions in an HTTP error code 500.

```
$ curl -i http://localhost:9292/api/raise
HTTP/1.1 500 Internal Server Error
Content-Type: text/html
```

The response body is the [HTML error page](public/errors/500.html). Additional response headers depend on the Rack server.

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
```

```
$ curl -X POST -i -F file=@api/ping.rb http://localhost:9292/api/download.rb

HTTP/1.1 201 Created
Content-Type: application/x-ruby
Content-Disposition: attachment; filename*=UTF-8''ping.rb
Vary: Origin

module Acme
  class Ping < Grape::API
    format :json
    get '/ping' do
      { ping: 'pong' }
    end
  end
end
```

### [stream_file](api/stream_file.rb)

An example that streams a file upload/download through an IO-like interface instead of reading the whole file into memory (see [`upload_file`](api/upload_file.rb) for the in-memory equivalent).

```
$ curl -X POST -i -F file=@spec/fixtures/grape_logo.png http://localhost:9292/api/download_stream

HTTP/1.1 201 Created
Content-Type: image/png
Content-Disposition: attachment; filename*=UTF-8''grape_logo.png
Cache-Control: no-cache
Vary: Origin
Transfer-Encoding: chunked
```

Download the streamed response to a file and verify it's identical to the upload.

```
$ curl -X POST -F file=@spec/fixtures/grape_logo.png http://localhost:9292/api/download_stream -o grape_logo_downloaded.png
$ cmp spec/fixtures/grape_logo.png grape_logo_downloaded.png && echo "identical"

identical
```

### [entities](api/entities.rb)

An example of using [grape-entity](https://github.com/ruby-grape/grape-entity).

```
$ curl http://localhost:9292/api/entities/1

{"tool":{"id":"1","length":10,"weight":"20kg"}}
```

### [headers](api/headers.rb)

Returns request headers or looks up an individual header. The casing of keys in the full header response depends on the Rack version.

```
$ curl http://localhost:9292/api/headers/Host

{"Host":"localhost:9292"}
```

### [stream_data](api/stream_data.rb)

An example of streaming data.

```
curl http://localhost:9292/api/stream --no-buffer
1
2
3
...
```

New Relic
---------

The application includes the New Relic Ruby agent. Set `NEW_RELIC_LICENSE_KEY` and optionally `NEW_RELIC_APP_NAME` to report to your New Relic account; configuration is in [`config/newrelic.yml`](config/newrelic.yml). A license key is not required to run the examples locally.
