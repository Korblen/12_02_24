# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Nettoyage de la base de données
City.destroy_all
User.destroy_all
Gossip.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all

# Création de 10 villes
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
puts "10 villes créées"

# Création de 10 utilisateurs
10.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 20),
    email: Faker::Internet.email,
    age: rand(18..70),
    city: City.all.sample
  )
end
puts "10 utilisateurs créés"

# Création de 20 gossips
20.times do
  Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user: User.all.sample
  )
end
puts "20 gossips créés"

# Création de 10 tags
10.times do
  Tag.create!(
    title: "##{Faker::Lorem.word}"
  )
end
puts "10 tags créés"

# Association de tags aux gossips (chaque gossip reçoit un tag aléatoire, pour simplifier)
Gossip.all.each do |gossip|
  gossip.tags << Tag.all.sample
end
puts "Tags associés aux gossips"

# Création de messages privés
10.times do
  sender = User.all.sample
  recipients = User.where.not(id: sender.id).sample(rand(1..5)) # Assurez-vous que l'expéditeur ne s'envoie pas de message à lui-même
  pm = PrivateMessage.create!(
    content: Faker::Lorem.paragraph(sentence_count: 2),
    sender: sender
  )
  pm.recipients << recipients
end
puts "Messages privés créés"