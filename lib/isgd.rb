#!/usr/bin/env ruby
#
## is.gd class
##
#
require 'rubygems'
require 'httpclient'

class Shortlink
    def isgd(link)
        clnt = HTTPClient.new
        clnt.get('http://is.gd/api.php', {:longurl => link} ).content
    end
end
