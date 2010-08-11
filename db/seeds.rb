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

pw = '1122334455'
User.create(:username => 'wito', :email => 'toosvanvroonhoven@home.nl', :password => pw, :password_confirmation => pw)