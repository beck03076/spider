require 'spec_helper'
require_relative '../utility'

describe CrawledLink do
  before :each do
    @crawled_link = CrawledLink.new 1,"http://www.simplesite.com",56
  end

  describe "#new" do
    it "takes parameters and returns a CrawledLink object" do
      @crawled_link.should be_an_instance_of CrawledLink
    end
  end

  describe "#value" do
    it "returns value" do
      @crawled_link.value.should be_an_instance_of Hash
      expect(@crawled_link.value).to include(:level,:links,:url,:count)
    end
  end
end
