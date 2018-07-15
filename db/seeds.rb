# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Starting add db seeds...'
puts "這個種子檔會自動創建 league definitions"

League.find_or_create_by!({name: "NBA", official_site: "https://data.nba.net/prod/v1/2018/teams.json"})
League.find_or_create_by!({name: "MLB", official_site: "https://www.si.com/mlb/"})