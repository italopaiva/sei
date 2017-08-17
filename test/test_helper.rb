$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'sei'
require 'byebug'

require 'minitest/autorun'
