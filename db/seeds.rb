# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
# Dir.glob(File.dirname(__FILE__) + '/../../spec/factories/*.rb').each do |file|
#   require file
# end

Product.destroy_all

100.times do |i|
  h = {
    :name        => Forgery(:name).company_name,
    :description => Forgery(:lorem_ipsum).paragraphs,
    :cents       => Forgery(:basic).number(:at_least => 50, :at_most => 25000),
    :sold        => Forgery(:basic).boolean
  }
  
  product = Factory.build(:product, h)
  
  if product.save
    p "Product '#{product}' created."
  else
    p "Product '#{product}' skipped."
  end
  
end

p "Done!"