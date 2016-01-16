require 'mechanize'
require_relative 'utility'
require_relative 'node_selector'

class Crawler
  include Utility

  attr_accessor :page,:url_source,:url_input_count

  def initialize url,depth,node
    @depth = depth
    @node = node
    @url_source = [url]
    @url_input_count = {}
    @agent = Mechanize.new
    @domain = host_name(url)
  end

  def crawl
    @current_url = @url_source.pop
    @page = @agent.get(@current_url)
  end

  def process_page
    node_selector = NodeSelector.new(@page,@node,@domain)
    node_selector.select_nodes
    @url_source = @url_source + node_selector.urls
    @url_input_count[@current_url] = node_selector.input_count
  end
end
