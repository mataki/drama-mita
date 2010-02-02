require File.dirname(__FILE__) + '/../spec_helper'

describe Episode do
  it "should be valid" do
    Episode.new.should be_valid
  end
end
