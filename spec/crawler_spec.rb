require 'spec_helper'
require_relative '../utility'

describe Crawler do
  before :each do
    @url = "http://www.simplesite.com/"
    @crawler = Crawler.new @url,{depth: 2,page_limit: 20,node: "input"}
  end

  describe "#new" do
    it "takes parameters and returns a Crawler object" do
      @crawler.should be_an_instance_of Crawler
    end
  end

  describe "#crawl" do
    it "grabs links of the page and counts the input" do
      expect { |b| @crawler.crawl(&b) }.to yield_with_args(Array,Fixnum)
    end
  end
end
