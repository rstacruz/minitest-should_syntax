require File.expand_path('../helper', __FILE__)

class Foo
  def get_true?
    true
  end

  def get_false?
    false
  end
end

describe "should" do
  it ".should ==" do
    2.should     == 2
    2.should_not == 3
    2.should.not == 3
  end

  it ".should !=" do
    2.should     != 3
    2.should_not != 2
    2.should.not != 2
  end

  it ".should.match" do
    "hi".should =~ /hi/
    "hi".should.match /hi/
    "hi".should_not =~ /HI/
    "hi".should.not.match /HI/
  end

  it ".should.be.nil?" do
    @foo.should.be.nil?
    1000.should_not.be.nil?
  end

  it ".should.respond_to" do
    "".should.respond_to(:empty?)
    "".should_not.respond_to(:lolwhat)
  end

  it ".should.raise" do
    should.raise(ZeroDivisionError) { 2 / 0 }
    # should_not.raise { 2 + 2 }
  end

  it ".should.be.empty" do
    [].should.be.empty
    [].should.empty
  end

  it ".should.not.be.empty" do
    [1].should_not.be.empty
    [1].should.include(1)
  end

  it ".should <" do
    2.should < 3
    1.should < 2
    2.should <= 2
    2.should <= 4
    4.should >= 4
    4.should >= 3
  end

  it ".should.be.kind_of" do
    Object.new.should.respond_to(:freeze)
    Object.new.should.be.kind_of(Object)
    Object.new.should.be.an.instance_of(Object)
  end

  it "should.be.equal again" do
    a = Object.new
    b = a
    a.should.be.equal(b)
    a.should.be(b)
    a.should_not.be.equal(Object.new)
  end


  it ".should.be.close" do
    Math::PI.should.be.close(22.0/7, 0.1)
  end

  it ".should.throw" do
    should.throw(:x) { throw :x }
    # should.not.throw { 2 + 2 }
  end

  it ".should.not.method_missing" do
    Foo.new.should.not.get_false
    Foo.new.should.get_true
  end

  it ".should.be" do
    a = Object.new
    b = a

    expects(:assert_same).with(a, b, nil)
    a.should.be(b)
  end

  it ".should.include" do
    expects(:assert_includes).with([], 2, nil)
    [].should.include 2
  end

  it ".should.not.include" do
    expects(:refute_includes).with([], 2, nil)
    [].should.not.include 2
  end

  it ".should.blaming" do
    expects(:assert_equal).with(4, 3, 'lol')
    3.should.blaming('lol') == 4
  end

  it ".msg" do
    expects(:assert_equal).with(4, 3, 'oh no')

    msg "oh no"
    3.should == 4
  end

  it ".should.blaming again" do
    object = Object.new

    expects(:assert).with(true).at_least_once # Because minitest does this
    expects(:assert).with(true, 'he cant dance')
    object.expects(:dance?).returns(true)

    object.should.blaming('he cant dance').dance
  end

  it ".should.satisfy" do
    expects :assert_block
    should.satisfy { false }
  end
end
