var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');

var config = {
  entry: {
    main: './app/assets/javascripts/main.js',
    main2: './app/assets/javascripts/main2.js',
  }
};

config.output = {
  path: path.join(__dirname, 'public', 'assets'),
  filename: '[name]-[hash].js',
};

config.resolve = {
  extensions: ['', '.js'],
  modulesDirectories: ['node_modules'],
};

config.plugins = [
  new StatsPlugin('webpack-common-manifest.json', {
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
  })
]

module.exports = config;
