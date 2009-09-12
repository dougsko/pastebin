#!/usr/bin/env ruby
#
#  Class to work with http://pastebin.ca
#

require 'rubygems'
require 'yaml'
require 'hpricot'
require 'httpclient'

class Pastebin
     # This method takes a hash containing the variables in the POST
     # request and an optional config file.  Only either "content" or
     # "raw" is required.
     #   pbin = Pastbin.new({ "content" => "file_path",
     #                        "name" => "",
     #                        "decription" => "",
     #                        "tags" => "",
     #                        "exipry" => "",
     #                        "type" => "",
     #                        "config" => "config file",
     #                        "raw" => "pastebin link",
     #                      })
     #
    def initialize(options)
        @options = options
        #@options.delete("raw")
        if @options.has_key?("config")
            @config = options["config"]
            @options.delete("config")
        else
            @config = "#{ENV['HOME']}/.paster.yaml"
        end
        @options["type"] = "1"
        if File.exists? @config
            config = YAML.load(File.open(@config))
        else
            config = {}
            puts "Please enter your API key.  You'll only have to do this once."
            print "You can get a key here: http://pastebin.ca/apikey.php \n "
            config['key'] = gets.chomp
            @options["api"] = config['key']
            open(@config, 'w'){ |f| YAML.dump(config, f) }
            puts "Thank you. Please run the script again. Run #{$0} --help to see all the options."
            exit
        end
    end

    # This POSTs the paste and returns the link
    #
    #   pbin.paste    #=> "http://pastebin.ca/xxxxxxx"
    #
    def paste
        if @options.has_key?("content")
            if @options["content"] == "-"
                @options["content"] = $stdin.read
            else
                File.open(@options["content"]) do |file|
                    @options["content"] = file.read
                end
            end
        else
            puts "You must specify a file or '-' for STDIN"
            exit
        end
        clnt = HTTPClient.new
        clnt.post("http://pastebin.ca/quiet-paste.php", @options).content[/(\w+):([\w\s]+)/]
        success_fail = $1
        code_reason = $2
        if success_fail == "SUCCESS"
            "http://pastebin.ca/" + code_reason
        elsif success_fail == "FAIL"
            "#{$0} Error: #{$2}"
        else
            "#{$0} Error: Unknown Error"
        end
    end

    # This method takes a link from a previous paste and returns the raw
    # text.
    #
    #   pbin.get_raw("http://pastebin.ca/xxxxxxx")    #=> "some text"
    #
    def get_raw(link)
        clnt = HTTPClient.new(:agent_name => 'ruby httpclient')
        clnt.get_content("http://pastebin.ca/raw/#{link[/\d+/]}")
    end
end
