require 'spec_helper'

describe Product do
  describe "validations" do
    it { should validate_presence_of(:name, :description) }
  end
  describe "named scopes" do
    it { should have_scope(:for_sale, :conditions => {:sold => false})}
  end
  
end
