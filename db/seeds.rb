# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Post.delete_all
Friendship.delete_all
Comment.delete_all

User.create!(email: "foobar@foobar.com",
             password: "foobar123")

60.times do |n|
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               password: password)
end

# Posts
users = User.all
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end

# Friendships
10.times do 
  Friendship.create(user_id: User.first.id, friend_id: users.sample.id, status: false)
end

15.times do 
  Friendship.create(user_id: users.sample.id, friend_id: User.first.id, status: false)
end

10.times do 
  Friendship.create(user_id: User.first.id, friend_id: users.sample.id, status: true)
end

# Comments
5.times do
  User.first.friends.each do |friend|
    friend.comments.create(post_id: User.first.posts.sample.id, comment: Faker::Lorem.sentence(5))
  end
end

25.times do 
  User.first.comments.create(post_id: User.first.friends.sample.posts.sample.id, comment: Faker::Lorem.sentence(5))
end

# Likes
10.times do
  Like.create(post_id: User.first.posts.sample.id, user_id: users.sample.id)
end

10.times do
  Like.create(post_id: User.first.friends.sample.posts.sample.id, user_id: User.first.friends.sample.id)
end