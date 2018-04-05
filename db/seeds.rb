# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to = Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

100.times do |i|
  archive_item = ArchiveItem.create(
      id: i,
      published: rand(2) == 1,
      hash_id: SecureRandom.hex(4),
      date: rand_time(14.days.ago),
      tags: Faker::Lorem.words(rand(6)).join(','),
      note: Faker::Lorem.sentence)

  I18n.locale = :en
  archive_item.title = Faker::Lorem.words(rand_int(1, 4)).join(' ')
  archive_item.description = Faker::Lorem.sentences(rand(5)).join(' ')

  I18n.locale = :cs
  archive_item.title = Faker::Lorem.words(rand_int(1, 4)).join(' ')
  archive_item.description = Faker::Lorem.sentences(rand(5)).join(' ')

  archive_item.save!
end