require 'spec_helper'

describe Product do
  describe "validations" do
    it { should validate_presence_of(:name, :description) }
  end
  
  describe "named scopes" do
    it { should have_scope(:for_sale, :conditions => {:sold => false})}
  end
  
  describe "amount" do
    describe "getter" do
      it "should return cents divided by 100" do
        product = Factory.build(:product, :cents => 123)
        product.amount.should eql(1.23)
      end

      it "should return nil if cents is nil" do
        product = Factory.build(:product, :cents => nil)
        product.amount.should be_nil
      end
    end

    describe "setter" do
      it "should set cents equal to aount multiplied by 100" do
        product = Factory.build(:product, :cents => nil)
        product.amount = 1
        
        product.cents.should eql(100)
      end

      it "should handle comma as decimals" do
        product = Factory.build(:product, :cents => nil)
        product.amount = '1,45'
        
        product.cents.should eql(145)
      end
    end
    
  end
end
