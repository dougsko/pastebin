require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Shortlink" do
  it "creates a Shortlink object" do
      Shortlink.new.class.to_s.should == "Shortlink"
  end

  it "Shorten a link" do
      Shortlink.new.isgd("http://google.com").should match(/http:.*\/[\d|\w]+/)
  end
end
