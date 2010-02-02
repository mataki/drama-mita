require File.dirname(__FILE__) + '/../spec_helper'

describe Watch do
  it "should be valid" do
    Watch.new.should be_valid
  end
end
