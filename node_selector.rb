class NodeSelector
  include Utility

  attr_accessor :urls,:input_count

  def initialize page,node,domain
    @page = page
    @node = node
    @domain = domain
  end

  def select_nodes
    @urls = @page.search("a")
    @input_count = @page.search(@node).count
    filter_urls_by_href
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
    case
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
