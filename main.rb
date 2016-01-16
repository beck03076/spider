require_relative 'crawler'
require 'set'

url_store = Set.new ["http://8and9.com/"]
final = []
depth = 0

while !url_store.empty? && depth == 50
  depth +=  1
  url = url_store.first
  url_store.subtract([url])
  obj = Crawler.new url,2,"input"
  obj.crawl
  obj.process_page
  url_store.merge(obj.url_source)
  final << obj.url_input_count
  p final
end
