module Utility
  def host_name(url)
    host = URI.parse(url).host
    if host.nil?
      ""
    else
      host.gsub(/www\./,"")
    end
  end

  def sub_folder?(url)
    !url.empty? && host_name(url).empty?
  end

  def excludable_links
    ["","#","/"]
  end
end
