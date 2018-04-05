# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

archive_items_count = 60
archive_files_images_max_count = 2
archive_files_images_min_count = 0

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

archive_items_count.times do |i|
  archive_item = ArchiveItem.create(
      published: rand(2) == 1,
      hash_id: SecureRandom.hex(4),
      date: rand_time(14.days.ago),
      tags: Faker::Lorem.words(rand(6)).join(','),
      note: Faker::Lorem.sentence)

  archive_item.id = i

  I18n.locale = :en
  archive_item.title = Faker::Lorem.words(rand_int(1, 4)).join(' ')
  archive_item.description = Faker::Lorem.sentences(rand(5)).join(' ')

  I18n.locale = :cs
  archive_item.title = Faker::Lorem.words(rand_int(1, 4)).join(' ')
  archive_item.description = Faker::Lorem.sentences(rand(5)).join(' ')

  archive_item.save!

  archive_files_images_count = rand_int(archive_files_images_min_count, archive_files_images_max_count)
  archive_files_images_count.times do |y|

    file = File.open(Rails.root + "app/assets/seeds/images/#{rand_int(1, 15)}.jpg")

    archive_file = ArchiveFile.create(
        file: file,
        file_type: 3, #just images for now
        language_id: rand_int(1, 2)
    )

    archive_file.archive_item_id = archive_item.id
    archive_file.save!
  end

  puts "archive_item #{archive_item.id} saved"
  puts "#{i}/#{archive_items_count}"
end