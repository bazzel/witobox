require 'spec_helper'

describe Product do
  describe "named scopes" do
    it { should have_scope(:for_sale, :conditions => {:sold => false})}
  end
  
end
