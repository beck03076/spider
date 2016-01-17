require_relative 'crawler'
require_relative 'crawled_link'
require_relative 'crawl_worker'
require 'set'
require "benchmark"

class Main
  attr_accessor :level_info

  def initialize(url,options = {})
    options[:depth] ||= 2
    options[:node] ||= "input"
    options[:page_limit] ||= 50

    @options = options
    @url_store = Set.new
    @crawled_links = {}
    @level_info = {}
    # initial level with the main url
    @level_info[0] = [{links: [url]}]
  end

  def execute
    # upto given depth
    1.upto(@options[:depth].to_i) do |i|
      @level_info[i - 1].compact.each do |j|
        # for a given page, crawl all links in the page concurrently
        if !j[:links].nil?
          futures = crawl_child_links(i,j[:links])
          @level_info[i] = futures.map &:value
          populate_url_store_crawled_links(@level_info[i])
        end
      end
    end
  end

  def output
    print_report
    1.upto(@options[:depth].to_i) do |i|
      puts "==== Level - #{i} ========"
      @level_info[i].compact.each do |hsh|
        print hsh[:url]
        print " - "
        print hsh[:count]
        if i == 1
          print " - "
          puts hsh[:links].map {|i| @crawled_links[i]}.compact.inject(:+)
        else
          puts ""
        end
      end
      puts "=========================="
    end
  end

  private

  def print_report
    puts ""
    puts "---------------------------"
    puts "No of Urls Crawled - #{@url_store.size}"
    puts "No of Inputs Counted - #{@crawled_links.values.inject(:+)}"
    puts "---------------------------"
  end

  def populate_url_store_crawled_links(level_output)
    # store all the urls crawled in url_store and also the crawled_links with input count
    @url_store.merge(level_output.compact.map {|i|
      @crawled_links[i[:url]] = i[:count]
      i[:url]
    })
  end

  def crawl_child_links(i,links)
    crawler_pool = CrawlWorker.pool(size: 16)
    links.map {|url|
      if !@url_store.include?(url)
        crawler_pool.future(:perform,url,i,@options)
      else
        CrawledLink.new(i,url,@crawled_links[url])
      end
    }
  end
end
