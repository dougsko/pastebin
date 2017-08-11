require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Pastebin" do
  before do
      `echo "hello world" > /tmp/hw.txt`
      options = {"paste_code" => "/tmp/hw.txt", 
                 "paste_expire_date" => "10 Minutes",
                 "paste_private" => "1"}
      @pbin = Pastebin.new(options)
  end

  after do
      `rm /tmp/hw.txt`
  end

  it "tests that @pbin is indeed a Pastebin object" do
      @pbin.class.to_s.should == "Pastebin"
  end

  it "should paste some text and return a link" do
      @link = @pbin.paste
      @link.should match(/https:.*\/[\d\w]+/)
  end

  it "should return raw text from a paste link" do
      link = @pbin.paste
      text = @pbin.get_raw(link)
      text.should match(/hello world/)
  end
end
