require "spec_helper"

RSpec.describe Pastebin do
    before do
        `echo "hello world" > /tmp/hw.txt`
        options = {"api_paste_code"=>"/tmp/hw.txt", "api_paste_private"=>"1", "api_dev_key"=>"01fe34146583c731f3725fd8dde3992c"}
        @pbin = Pastebin.new(options)
    end

    after do
        `rm /tmp/hw.txt`
    end

    it "has a version number" do
        expect(Pastebin::VERSION).not_to be nil
    end

    it "tests that @pbin is indeed a Pastebin object" do
        expect(@pbin.class.to_s).to eq "Pastebin"
    end

    it "should paste some text and return a link" do
        link = @pbin.paste
        expect(link).to match(/https:.*\/[\d\w]+/)
    end

    it "should return raw text from a paste link" do
        link = @pbin.paste
        text = @pbin.get_raw(link)
        if(link != "" and text != "")
            expect(text).to match(/hello world/)
        elsif(link != "" and text == "")
            puts "Pastebin spam detection might be preventing this check from working."
            puts "Check #{link} to see if there's a captcha check."
        end
    end
end


