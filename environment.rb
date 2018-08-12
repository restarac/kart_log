# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'

Bundler.setup(:default)

require 'lib/summary'
Bundler.require(:default)
