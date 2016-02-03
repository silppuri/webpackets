[![Build Status](https://travis-ci.org/silppuri/webpackets.svg?branch=master)](https://travis-ci.org/silppuri/webpackets)

# Webpackets::Rails

Manage your static assets with Webpack in your Rails application and turn 
```
//= require jquery
```
 into this:
 
 ```javascript
 var App = require('./app')
 ```

## Installation

:warning: Currently I do not recommend using this gem as this lacks good generator task for installing the required npm-packages and default `webpack.config.js` files. But if you want to play around:

```ruby
gem `webpackets`, git: 'https://github.com/silppuri/webpackets/'
```

## Usage

For every entry in `webpack.config.js` you can use `javascript_include_tag` in your templates:

With the usual rails default directory structure:
```
app
|-- assets
|    |-- javascripts 
|    |    |-- application.js
|    |    |-- boot.js
| ...
|
webpack.config.js
```

In the webpack's config file with the enries defined:
```
// webpack.config.js
var config = {
  entry: {
    application: './app/assets/javascripts/application.js',
    boot: './app/assets/javascripts/boot.js'
  }
};
```

```javasript
// application.js
console.log("Hello Webpackets")
```

```javasript
// boot.js
console.log("Wat?")
```

With the normal Rails template `application.html.erb`
```erb
<%= javascript_include_tag 'application' %>
<%= javascript_include_tag 'boot' %>
```

`rails server`
Then when running the server the webpack compiles the files defined and after navigating to `localhost:3000` we can se that it works as a charm:


```
>> Hello Webpackets
>> Wat?
```

## Development

TODO:

- [ ] generator for initial webpack config
- [ ] precompile tasks
- [ ] production

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/silppuri/webpackets.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

