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

:warning: Currently I do not recommend using this gem as this lacks a good generator task for installing the required npm-packages and for generating the default `webpack.config.js` file. But if you want to play around:

```ruby
gem `webpackets`, git: 'https://github.com/silppuri/webpackets/'
```

Then run the generator:
```
rails generate webpackets:install
```
This will search for the `package.json`, install the required depedencies and copy a default `webpack.config.js` file and replace the old `application.js` with a new one.

After this the webpackets is ready for usage!

## Usage

For every entry in `webpack.config.js` file you can use `javascript_include_tag` in your templates:

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

In the webpack's config file with the entries defined:
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

When running the `rails server` command the webpack starts its development server and serves the files from there. And now in the console at `localhost:3000` we can se that this works like a charm:

```
>> Hello Webpackets
>> Wat?
```

### CSS

This does not yet take CSS into account, but with some configuration you can make it work: [Webpack's css instructions](https://webpack.github.io/docs/stylesheets.html)

## Development

TODO:

- [ ] precompile tasks
- [ ] production

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/silppuri/webpackets.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

