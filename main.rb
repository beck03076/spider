require_relative 'crawler'
require_relative 'crawled_link'
require_relative 'crawl_worker'
require 'set'
require "benchmark"

url_store = Set.new
main_url = ["http://railscasts.com/"]
crawled_links = {}
level_info = {}


def crawl_child_links(i,links,ustore,crawled_links)
  crawler_pool = CrawlWorker.pool(size: 16)

  links.map {|url|
    if !ustore.include?(url)
      crawler_pool.future(:perform,url,i)
    else
      CrawledLink.new(i,url,crawled_links[url])
    end
  }
end


# initial level with the main url
level_info[0] = [{links: main_url}]

# upto given depth
1.upto(3) do |i|
  level_info[i - 1].compact.each do |j|
    # for a given page, crawl all links in the page concurrently
    futures = crawl_child_links(i,j[:links],url_store,crawled_links)
    level_info[i] = futures.map &:value
    # store all the urls crawled in url_store and also the crawled_links with input count
    url_store.merge(level_info[i].compact.map {|i|
      crawled_links[i[:url]] = i[:count]
      i[:url]
    })
  end
end

p "============ Result =========="
result = []
p level_info[1].first[:links].map {|i| crawled_links[i]}.compact.inject(:+)
level_info[2].each do |i|
  p i[:url]
  p i[:count]
end
# result << [3,level_info[3].map{|i| [i[:url],i[:count]] if !i[:links].empty?  }]
# result << [2,level_info[2].map{|i| [i[:url],i[:count]] if !i[:links].empty?  }]
# p result
