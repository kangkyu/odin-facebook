# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

email = "@fakeemaildoesntexist.com"

users = [
  ["george", "foobar123"],
  ["thomas", "foobar123"],
  ["benji", "foobar123"],
  ["abe", "foobar123"],
  ["theodore", "foobar123"],
]

users.each do |name, password|
  User.create(email: name + email, password: password)
end


User.create(email: "guest@guest.com", password: "guest123")
