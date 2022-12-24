# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Format.create(name: 'Commander', max_same: 1, min_cards: 100, max_cards: 100)
Format.create(name: 'Standard')
Format.create(name: 'Modern')
