require 'spec_helper'
require_relative '../utility'

describe Main do
  before :all do
    @url = "http://www.simplesite.com/"
    @main = Main.new @url,{depth: 2,page_limit: 20,node: "input"}
    @main.execute
  end

  describe "#new" do
    it "takes parameters and returns a Main object" do
      @main.should be_an_instance_of Main
    end
  end

  describe "#execute" do
    it "sets level_info the result hash" do
      @main.level_info.keys.should include(1,2)
      [1,2].each do |i|
        @main.level_info[i].should be_an_instance_of(Array)
      end
    end
  end

  describe "#execute" do
    it "level_info is an array of hash" do
      [1,2].each do |i|
        @main.level_info[i].each do |j|
          j.should be_an_instance_of(Hash)
        end
      end
    end
  end

  describe "#execute" do
    it "level_info's final hashes should have right keys" do
      [1,2].each do |i|
        @main.level_info[i].each do |j|
          expect(j).to include(*[:links,:url,:level,:count])
        end
      end
    end
  end

end
