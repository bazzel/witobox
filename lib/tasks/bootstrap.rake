namespace :db do
  desc "Recreates the database and then loads the initial database fixtures."
  task :bootstrap do |task_args|
    mkdir_p File.join(RAILS_ROOT, 'log')

    %w(environment db:drop db:create db:migrate db:bootstrap:products tmp:create).each { |t| Rake::Task[t].execute task_args}

    puts
    puts '=' * 80
    puts
    puts "WitoBox has been bootstrapped!"
    puts
    puts "Now you can start the application with script/server, visit "
    puts "http://localhost:3000"
    puts
  end

  namespace :bootstrap do
    desc "Load sample products into the current environment's database."
    task :products => :environment do
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

    end
  end
end