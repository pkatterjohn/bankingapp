# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create Base Organizations
Organization.create(name: 'Bank of Superior Access', external_id: 'superbank')
Organization.create(name: 'Bank of Canada', external_id: 'canadabank')
Organization.create(name: 'Bank of Germany', external_id: 'germanybank')
Organization.create(name: 'Bank of Japan', external_id: 'japanbank')

#Create SuperUser
User.create(first_name: 'Philip', last_name: 'Katterjohn', admin: 2, login: 'superuser', password: 'byebuddy', organization_id: Organization.find_by_external_id('superbank').id)

#Create Users for Organizations
organizations = Organization.all
users = (1..(organizations.length*10)).to_a
organizations.each do |org|
  users.take(10).each do |user|
    User.create(first_name: "First#{user.to_s}", last_name: "Last#{user.to_s}", admin: 0, login: "User#{user.to_s}", password: "Password#{user.to_s}", organization_id: org.id)
  end
  users = users.drop(10)
  User.create(first_name: "admin", last_name: "user", admin: 0, login: "#{org.external_id}", password: "Password", organization_id: org.id)
end

#Create Accounts for each User
User.all.each do |user|
  user.initialize_accounts
end

Account.all.each do |acct|
  acct.deposit((rand * 1000).round(2))
end
