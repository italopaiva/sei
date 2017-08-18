$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'sei'
require 'byebug'

require 'support/services_helper'
include ServicesHelper

require 'minitest/autorun'
