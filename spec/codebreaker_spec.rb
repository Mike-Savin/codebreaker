require 'spec_helper'
 
describe Codebreaker do
  context "#name" do
    it "should return gem name" do
      Codebreaker.name.should == "Codebreaker"
    end
  end
end