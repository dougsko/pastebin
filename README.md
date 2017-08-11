= pastebin

pastebin is a CLI to http://pastebin.com
	Usage: pastebin [options] 
	Examples: pastebin -f foo.rb -t ruby -e '10 Minutes'
	          cat foo.pl | pastebin -f - -t perl

Options:
    -f, --file <file>                Use a file for input, use "-" for STDIN
    -n, --name <name>                Assign a name/title to your paste
    -s, --subdomain <subdomain>      Paste to a specific subdomain
    -r, --raw <link>                 Return raw text from a paste link
    -e, --expire <time>              These can be abbriviated, as long as they are unambigous. Defaults to '1 Month'
                                     Never, 10 Minutes, 1 Hour, 1 Day, 1 Month
    -l, --language <syntax>          Syntax types can be abbriviated, as long as they are unambigous. There are many more supported languages than what is listed here. Defaults to 'text'
                                       perl, python, c, ruby, bash, cpp, groovy, latex, java, php, sql, xml
    -p, --private                    Make paste private.
    -h, --help                       Show this message


== Copyright

Copyright (c) 2010 dougsko. See LICENSE for details.
