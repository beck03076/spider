class CrawledLink
  def initialize(level,url,input_count)
    @level = level
    @url = url
    @input_count = input_count
  end

  def value
    {level: @level, links: [],url: @url,count: @input_count}
  end
end
