class NodeSelector
  include Utility

  attr_accessor :urls,:input_count

  def initialize page,node,domain,page_limit
    @page = page
    @node = node
    @domain = domain
    @page_limit = page_limit
  end

  def select_nodes
    @urls = @page.search("a")[0..(@page_limit)]
    @input_count = @page.search(@node).count
    filter_urls_by_href
  rescue NoMethodError => e
    puts e.message
  end

  def filter_urls_by_href
    arr = []
    @urls.map {|i|
      link_href = i.attr("href")
      arr << crawlable(link_href)
    }
    @urls = arr.flatten.compact
  end

  def crawlable(link)
    link = URI.encode(link) if !link.nil?
    case
    when link.nil?
      nil
    when excludable_links.include?(link)
      nil
    when sub_folder?(link)
      ["http://",@domain,link].join
    when @domain == host_name(link)
      link
    else
      nil
    end
  end

end
