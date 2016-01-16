require 'spec_helper'
require_relative '../utility'

describe Crawler do
  before :each do
    @domain_name = "http://www.8and9.com/"
    @crawler = Crawler.new @domain_name,"3","input"
  end

  describe "#new" do
    it "takes three parameters and returns a Crawler object" do
      @crawler.should be_an_instance_of Crawler
    end
  end

  describe "#crawl" do
    it "grabs the html of the given url stores it in page" do
      @crawler.crawl
      @crawler.page.content_type.should include "text/html"
    end
  end

  describe "#fill_store_url" do
    it "stores url_store array with all same domain urls" do
      p "=="
      @crawler.crawl
      @crawler.process_page
      @crawler.url_source.all?{|i| i.is_a?(String)} 
    end
  end

end
