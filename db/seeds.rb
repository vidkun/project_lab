# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = ['Sam', 'Jane','Fred','Kim','Jack']

users.each do |user|
  User.create!(
    name: user,
    email: "#{user}@email.com",
    password: 'password',
    password_confirmation: 'password',
    phone: 8015551234)
end


User.all.each do |user|
  Project.create!(
    name: "#{user.name}'s Project",
    description: "This project was created by #{user.name}. This project was created by #{user.name}. This project was created by #{user.name}. This project was created by #{user.name}. ",
    due_date_at: "2015-09-29 00:00:00",
    user_id: user.id)
end


