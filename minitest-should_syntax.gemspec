require "./lib/minitest/should_syntax/version"
Gem::Specification.new do |s|
  s.name = "minitest-should_syntax"
  s.version = MiniTest::ShouldSyntax.version
  s.summary = "RSpec-like syntax for MiniTest."
  s.description = "Lets you use a syntax similar to RSpec on your MiniTest tests."
  s.authors = ["Rico Sta. Cruz"]
  s.email = ["rico@sinefunc.com"]
  s.homepage = "http://github.com/rstacruz/minitest-should_syntax"
  s.files = `git ls-files`.strip.split("\n")

  s.add_dependency "minitest"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
end
