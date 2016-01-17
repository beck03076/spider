require "celluloid"
require 'celluloid/autostart'

class CrawlWorker
  include Celluloid
  trap_exit :resume

  def perform(url,level,options)
    print "="
    crawler = Crawler.new(url,options)
    crawler.crawl do |urls,node_count|
      {level: level,url: url,links: urls,count: node_count }
    end
  end

  def resume(actor, reason)
    nil
  end
end
