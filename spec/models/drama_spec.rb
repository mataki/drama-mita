require File.dirname(__FILE__) + '/../spec_helper'

describe Drama do
  it "should be valid" do
    Drama.new.should be_valid
  end
end
