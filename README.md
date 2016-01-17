# Spider
This is a spider.

# Core Functionality

This spider takes in 4 main arguments, namely,
Depth -d, Url -u, Node -n, Page Limit -p

Based on the arguments given to the spider, it will crawl the given url to scrape all the links and count the number of html nodes(input, form, a, h1, etc) present in the html page, recursively upto x levels as given in the depth parameter.

# Steps to execute

- git clone git@github.com:beck03076/spider.git
- bundle install
- ./script.rb -n input -p 50 -d 2 -u http://example.com

# Steps to test

- rspec spec
- Test coverage results will be stored in coverage/index.html

# Steps to check LOC

- ./loc.sh
- ./loc_with_test.sh

# Sample Output
```sh
==================
---------------------------
No of Urls Crawled - 16
No of Inputs Counted - 143
---------------------------
==== Level - 1 ========
http://www.apple.com/in/ - 9 - 134
==========================
==== Level - 2 ========
http://apple.com/in/ - 9
http://apple.com/in/mac/ - 9
http://apple.com/in/ipad/ - 9
http://apple.com/in/iphone/ - 9
http://apple.com/in/watch/ - 10
http://apple.com/in/tv/ - 10
http://apple.com/in/music/ - 10
http://apple.com/in/support/ - 6
http://apple.com/in/buy/ - 5
http://apple.com/in/search - 7
http://apple.com/in/start-something-new/ - 10
http://apple.com/in/ipad-pro/ - 10
http://apple.com/in/iphone-6s/ - 10
http://apple.com/in/ipad-mini-4/ - 10
http://apple.com/in/macbook/ - 10
==========================
```
