require "celluloid"
require 'celluloid/autostart'

class CrawlWorker
  include Celluloid
  trap_exit :resume

  def perform(url,level)
    if !url.include?("javascript")
      puts "crawling #{url}.."
      obj = Crawler.new url,2,"input",50
      obj.crawl
      obj.process_page
      {level: level,url: url,links: obj.urls,count: obj.url_input_count }
    end
  end

  def resume(actor, reason)
    puts "One actor failed!"
  end
end
