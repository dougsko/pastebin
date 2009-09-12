require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Pastebin" do
  before do
      `echo "hello world" > /tmp/hw.txt`
      options = {"content" => "/tmp/hw.txt", "expiry" => "5 minutes"}
      @pbin = Pastebin.new(options)
  end

  it "tests that @pbin is indeed a Pastebin object" do
      @pbin.class.to_s.should == "Pastebin"
  end

  it "should paste some text and return a link" do
      @paste = @pbin.paste
      @paste.should match(/http:.*\/\d+/)
  end

  it "should return raw text from a paste link" do
      @paste = @pbin.paste
      text = @pbin.get_raw(@paste)
      text.should match(/hello world/)
  end
end
