# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new(login: "Jarek",
	     email: "jaro@wp.pl",
	     password: "EnterYourPassword",
         password_confirmation: "EnterYourPassword",
         admin: true).save

Article.new(title: "Pekin").save