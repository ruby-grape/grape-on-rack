Grape API on Rack
=================

[![Build Status](https://secure.travis-ci.org/dblock/grape-on-rack.png)](http://travis-ci.org/dblock/grape-on-rack)

A [Grape](http://github.com/intridea/grape) API mounted on Rack.

* [ping](api/ping.rb): a hello world example that returns a JSON document
* [post_put](api/post_put.rb): a simple `POST` and `PUT` example
* [post_json](api/post_json.rb): an example that shows a `POST` of JSON data
* [rescue_from](api/rescue_from.rb): an example of `rescue_from` that wraps all exceptions in an HTTP error code 500
* [path_versioning](api/path_versioning.rb): an example that uses path-based versioning
* [header_versioning](api/header_versioning.rb): an example that uses vendor header-based versioning
* [wrap_response](api/wrap_response.rb): a middleware that wraps all responses and always returns HTTP code 200
* [content_type](api/content_type.rb): an example that overrides the default `Content-Type`
* [upload_file](api/upload_file.rb): an example that demonstrates a file upload

Run
---

```
bundle install
rackup
```

Try http://localhost:9292/api/ping.

New Relic
---------

The application is setup with NewRelic w/ Developer Mode. Navigate to http://localhost:9292/newrelic after making some API calls.
