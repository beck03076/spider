module Utility
  def host_name(url)
    host = URI.parse(url).host
    if host.nil?
      ""
    else
      host.gsub(/www\./,"")
    end
  rescue URI::InvalidURIError => e
    nil
  end

  def sub_folder?(url)
    !url.empty? && host_name(url).to_s.empty? && url[0..2] != "www"
  end

  def excludable_links
    ["","#","/"]
  end

  def excludable_patterns
    ["javascript","mail"]
  end

  def add_http(url)
    if url[0..1] == "//"
      "http:" + url
    else
      url
    end
  end

  def rescued_search(*params)
    yield if block_given?
  rescue NoMethodError => e
    nil
  end

end
