$:.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'minitest/should_syntax'
require 'mocha/setup'

class UnitTest < MiniTest::Unit::TestCase
end
