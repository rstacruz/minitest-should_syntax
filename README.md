# minitest-should_syntax

Rspec-like matching for MiniTest.

*minitest-should_syntax* lets you use a syntax similar to RSpec on your MiniTest 
tests.  It monkey-patches Object to translate RSpec-like sugar into plain 
MiniTest `assert` matchers.

(*Ouch! Monkey patch?* Yes! But it only defines `Object#should` and 
 `#should_not`.)

```
$ gem install minitest-should_syntax
```

## Basic usage

``` ruby
require 'minitest/autorun'
require 'minitest/should_syntax'

describe "Books" do
  it "should work" do
    book = Book.new title: "Revolution"

    book.title.should == "Revolution"
  end
end

```

## Should

Then you may use it as so:

```ruby
  obj.should == 2                    # => assert_equal 2, obj
  obj.should =~ /regex/              # => assert_match /regex/, obj
  obj.should != 3                    # => assert_not_equal 3, obj
  obj.should.nil                     # => assert_nil obj
  obj.should.respond_to(:freeze)     # => assert_respond_to obj, :freeze 

# Note that .be, .a and .an are optional.
  obj.should.nil                     # => assert_nil obj
  obj.should.be.nil                  # => assert_nil obj
  obj.should.be.a.nil                # => assert_nil obj

# You can also use should.not:
  obj.should.not == 3
  obj.should.not.be.nil

# Anything else will pass through with a ?:
  obj.should.be.good_looking         # => assert obj.good_looking?

# Testing exceptions:
  should.raise(ZeroDivisionError) { 2/0 }

# should_not is an alias for should.not:
  obj.should_not == 3
```

## Wrapped assertions

These are based on [MiniTest::Assertions].

| MiniTest::ShouldSyntax                  | [MiniTest::Assertions]      |
|-----------------------------------------|-----------------------------|
| x.should.equal y                        | assert_equal x, y           |
| x.should == y                           | assert_equal x, y           |
| x.should.not.equal                      | refute_equal x, y           |
| x.should !=                             | refute_equal x, y           |
| x.should.be                             | assert_same x, y            |
| x.should.not.be                         | refute_same x, y            |
| x.should >= *(and others)*              | assert_operator x, :>=, y   |
| x.should.not >= *(and others)*          | refute_operator x, :>=, y   |
| x.should.be.nil                         | assert_nil x                |
| x.should.not.be.nil                     | refute_nil x                |
| x.should.be.close y                     | assert_in_delta y           |
| x.should.be.in_epsilon y                | assert_in_epsilon y         |
| x.should.match /y/                      | assert_match x, /y/         |
| x.should =~ /y/                         | assert_match x, /y/         |
| x.should.not.match, should.not =~       | refute_match                |
| x.should.be.an.instance_of y            | assert_instance_of x, y     |
| x.should.be.a.kind_of x, y              | assert_kind_of x, y         |
| x.should.respond_to :y                  | assert_respond_to x, :y     |
| should.raise(x) { ... }                 | assert_raise(x) { ... }     |
| should.throw(x) { ... }                 | assert_throws(x) { ... }    |
| should.satisfy { ... }                  | assert_block { ... }        |

[MiniTest::Assertions]: https://github.com/seattlerb/minitest/blob/master/lib/minitest/unit.rb

## Messages

Use the `otherwise` helper:

``` ruby
it "should work" do
  book = Book.new title: "Pride & Prejudice"

  otherwise "The title should've been set on constructor"
  book.title.should == "Pride & Prejudice"
end
```

Result:

```
1) Failure:
should work(Test) [your_test.rb:77]:
The title should've been set on constructor.
Expected: "Pride & Prejudice"
  Actual: nil
```

Or you can use `.blaming` which does the same thing (with a more cumbersome 
    syntax):

``` ruby
it "should work" do
  book = Book.new title: "Pride & Prejudice"

  message = "The title should've been set on constructor"
  book.title.should.blaming(message) == "Pride & Prejudice"
end
```

## Extending

Need to create your own matchers? Create your new matcher in a module, then use 
`MiniTest::ShouldSyntax.add`.

```ruby
module DanceMatcher
  def boogie_all_night!
    # Delegates to `assert(condition, message)`.
    #
    #   positive?   - returns `true` if .should, or `false` if .should.not
    #   test        - the MiniTest object
    #   msg         - the failure message. `nil` if not set
    #
    if positive?
      test.assert left.respond_to?(:dance), msg
    else
      test.refute left.respond_to?(:dance), msg
    end
  end
end

MiniTest::ShouldSyntax.add DanceMatcher

# Then in your tests, use:
dancer.should.boogie_all_night!
```

## Ruby 1.8 warning

If you're going to target Ruby 1.8, avoid using `.should !=`. Use
`.should.not ==` instead.

Reason: 1.8 doesn't allow overriding the != operator, so any `.should !=` will 
silently work differently in 1.8.

## Acknowledgements & licensing

(c) 2013 Rico Sta. Cruz, MIT license
