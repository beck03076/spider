require 'mechanize'
require_relative 'utility'
require_relative 'node_selector'

class Crawler
  include Utility

  attr_accessor :page,:urls,:url_input_count

  def initialize url,depth,node,page_limit
    @urls = []
    @url_input_count = 0
    @depth = depth
    @node = node
    @url = url
    @agent = Mechanize.new 
    @domain = host_name(url)
    @page_limit = page_limit
  end

  def crawl
    @page = @agent.get(URI.encode(@url))
  rescue => e
    puts e.message
  end

  def process_page
    if !@page.nil?
      node_selector = NodeSelector.new(@page,@node,@domain,@page_limit)
      node_selector.select_nodes
      @urls = node_selector.urls.to_a.uniq
      @url_input_count = node_selector.input_count
    end
  end
end
