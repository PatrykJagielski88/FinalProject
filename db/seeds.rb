Category.destroy_all
Product.destroy_all
AdminUser.destroy_all

csv_file = Rails.root.join('db/categories.csv')
csv_data = File.read(csv_file)

categories = CSV.parse(csv_data, encoding: 'utf-8')

categories.each do |row|
  row.each do |r|
    puts r
    cat = Category.create(
      name: r
    )
  end
end

100.times do
  prod = Product.create(
    name: (Faker::Creature::Animal.name + ' ' + Faker::Creature::Cat.name).capitalize,
    category_id: rand(47..50),
    price: Faker::Number.decimal(l_digits: 1),
    description: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4)
  )

  query = URI.encode_www_form_component(['cat toy'])
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  prod.image.attach(io: downloaded_image, filename: "m-#{[prod.name].join('-')}.jpg")
end

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end
