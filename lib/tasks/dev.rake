namespace :dev do


  task :fake => :environment do
    User.delete_all
    Post.delete_all
    Comment.delete_all

    user = User.create!(:email => "abc@gmail.com", :password =>"12345678")

    puts "creating fake data"

    50.times do |i|
      e = Post.create( :name => Faker::App.name)
      10.times do |j|
        e.comments.create(:name => Faker::Name.name)
      end
    end

    20.times do |k|
      e = User.create( :first_name => Faker::Internet.user_name, :email => Faker::Internet.email)
    end

  end
end
