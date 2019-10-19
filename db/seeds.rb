# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Author.new(name: "Administrator RMIT",
         email: "admin",
         password: "password",
         password_confirmation: "password",
         admin: true).save(validate: false)

Author.create!(name: "William Low",
             email: "williamlow@rmit.com",
             password: "@123Qwerty",
             password_confirmation: "@123Qwerty")

Author.create!(name: "Syed Hariz",
             email: "syedhariz@rmit.com",
             password: "Pass123!",
             password_confirmation: "Pass123!")

drslump = Book.new(name: 'Dr. Slump', author_id: 2, description: 'Dr. Slump is a Japanese manga series written and illustrated by Akira Toriyama.')
harrypotter = Book.new(name: 'Harry Potter', author_id: 2, description: 'Harry Potter is a series of fantasy novels written by British author J. K. Rowling.')
wow = Book.new(name: 'World Of Warcraft', author_id: 2, description: 'The World of Warcraft book series by multiple authors includes books Cycle of Hatred, Rise of the Horde, Tides of Darkness, and several more.')
java = Book.new(name: 'Introduction To Java Programming', author_id: 2, description: 'This is sample Advance Programming for RMIT university')

manga = Category.create!(name: 'Manga')
fantasy = Category.create!(name: 'Fantasy')
edu = Category.create!(name: "Education")

drslump.categories << manga
harrypotter.categories << fantasy
wow.categories << fantasy
java.categories << edu

shonen = Distributor.create!(name: 'Weekly Shonen Jump')
bloom = Distributor.create!(name: 'Bloomsburry')
pear = Distributor.create!(name: 'Pearson')
bliz = Distributor.create!(name: 'Blizzard')

drslump.distributors << shonen
harrypotter.distributors << bloom
java.distributors << pear
wow.distributors << bliz

drslump.save(validate: true)
harrypotter.save(validate: true)
wow.save(validate: true)
java.save(validate: true)
