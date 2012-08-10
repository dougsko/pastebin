#!/usr/bin/env ruby
#
#  Class to work with http://pastebin.com
#
require 'net/http'
require 'uri'
require 'rexml/document'

class Pastebin
    include REXML

    DEVKEY = "01fe34146583c731f3725fd8dde3992c"

    # The only option required is 'paste_code', which holds your string.
    #
    def initialize(options)
        @options = options
        @options["api_dev_key"] = DEVKEY
    end

    # This POSTs the paste and returns the link
    #
    #   pbin.paste    #=> "http://pastebin.com/xxxxxxx"
    #
    def paste
        if @options.has_key?("api_paste_code")
            if @options["api_paste_code"] == "-"
                @options["api_paste_code"] = $stdin.read
            else
                File.open(@options["api_paste_code"]) do |file|
                    @options["api_paste_code"] = file.read
                end
            end
        #else
        #    puts "You must specify a file or '-' for STDIN"
        #    exit
        end
        @options["api_option"] = "paste"
        Net::HTTP.post_form(URI.parse('http://pastebin.com/api/api_post.php'),
                            @options).body
    end

    # This method takes a link from a previous paste and returns the raw
    # text.
    #
    #   pbin.get_raw("http://pastebin.com/xxxxxxx")    #=> "some text"
    #
    def get_raw(link)
        paste = Net::HTTP.get_response(URI.parse("http://pastebin.com/raw.php?i=#{link[/[\w\d]+$/]}")).body
        doc = Document.new(paste)
        doc.elements.to_a("//pre")[0].text
    end
end
