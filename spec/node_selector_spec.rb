require 'spec_helper'
require_relative '../utility'

describe NodeSelector do

  before :all do
    agent = Mechanize.new
    @url = "http://www.simplesite.com/"
    @host = "simplesite.com"
    @page = agent.get(@url)
  end

  before :each do
    @selector = NodeSelector.new @page,{domain: @host,page_limit: 20,node: "input"}
  end

  describe "#new" do
    it "takes parameters and returns a nodeselector object" do
      @selector.should be_an_instance_of NodeSelector
    end
  end

  describe "#detect_urls" do
    it "grabs links of the page and does lot of cleaning and excludes unwanted links" do
      urls = @selector.detect_urls
        urls.should be_an_instance_of(Array)
        expect(urls.sample).to include(@url)
    end
  end

  describe "#count_nodes" do
    it "count the given html node occurences" do
      @selector.count_nodes.should be_an_instance_of(Fixnum)
    end
  end

end
