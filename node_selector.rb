class NodeSelector
  include Utility
  attr_accessor :page,:options

  def initialize page,options = {}
    @page = page
    @options = options
  end

  def detect_urls
    dirty_urls = rescued_search { @page.search("a")[0..(@options[:page_limit].to_i)] }
    clean_urls(dirty_urls) if !dirty_urls.nil?
  end

  def count_nodes
    rescued_search { @page.search(@options[:node]).count }
  end

  private

  def clean_urls(urls)
    arr = []
    urls.map {|i|
      link_href = i.attr("href")
      a =  crawlable(link_href)
      arr << a
    }
    arr.flatten.compact.to_a.uniq
  end

  def crawlable(link)
    encoded_link = URI.encode(link.strip) if !link.nil?
    case
    when link.nil?, encoded_link.nil?, excludable_patterns.any? { |s| link.include?(s) }, excludable_links.include?(link)
      nil
    when sub_folder?(encoded_link)
      ["http://",@options[:domain],encoded_link].join
    when @options[:domain] == host_name(encoded_link)
      add_http(encoded_link)
    else
      nil
    end
  end

end
