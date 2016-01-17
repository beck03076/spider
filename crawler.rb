require 'mechanize'
require_relative 'utility'
require_relative 'node_selector'
require 'active_support/core_ext/hash/slice'

class Crawler
  include Utility

  def initialize(url, options = {})
    # Set default options here, using the ||= so if a value
    # already exists in the options hash, it's used.
    options[:domain] = host_name(url)

    @url = url
    @options = options
  end

  def crawl(&block)
    page = agent.get(URI.encode(@url))
    return if !page.header["content-type"].include?("text/html")
    urls = detect_urls_on_page(page)
    input_count = count_nodes_on_page(page)
    block.call(urls, input_count)
  rescue => e
    nil
  end

  private

  def agent
    @agent ||= Mechanize.new
  end

  def node_selector(page)
    @node_selector ||= NodeSelector.new(page,@options.slice(:node,:domain,:page_limit))
  end

  def detect_urls_on_page(page)
    selector = node_selector(page)
    selector.detect_urls
  end

  def count_nodes_on_page(page)
    selector = node_selector(page)
    selector.count_nodes
  end
end

