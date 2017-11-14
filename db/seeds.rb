# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

########################
# Supporting Variables #
########################

image_path = "#{Rails.root}/app/assets/images/testbasket.jpg"
image_file = File.new(image_path)

############
# Wave One #
############

states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut',
  'Delaware', 'District of Columbia', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois',
  'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts',
  'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
  'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon',
  'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
  'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming']

states.each do |state|
  State.create({state_name: state})
end

countries = ['USA', 'Canada', 'Mexico']

countries.each do |country|
  Country.create({country_name: country})
end

(1..12).each do |n|
  item = Item.create(name: "Basket #{n}", description: 'Test Basket', available: true, price: 150)
  ItemImage.create(item: item, file: ActionDispatch::Http::UploadedFile.new(
    :filename => File.basename(image_file),
    :tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type))
end

OrderLineStatus.create([
  {status: 'Unfulfilled'},
  {status: 'Preparing'},
  {status: 'Fulfilled'}])

OrderStatus.create([
  {status: 'Placed'},
  {status: 'In Progress'},
  {status: 'Completed'}])

############
# Wave Two #
############

User.create!([
  {email: "admin@test.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, first_name: "Ethan", last_name: "Orcutt", address: '15306 Highland Elm St', city: 'Houston', state_id: 44, country_id: 1, zip: 77433, active: nil, phone: nil, admin: true},
  {email: "user@test.com", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, first_name: "Ethan", last_name: "Orcutt", address: '15306 Highland Elm St', city: 'Houston', state_id: 44, country_id: 1, zip: 77433, active: nil, phone: 7124123476, admin: false},
  {email: "oliver.heart.gifts@gmail.com", password: "password", password_confirmation: "password", encrypted_password: "$2a$11$ZOo.IACCUcTR5VSHB2dvEes0RYpE6FzC/mGeFZUO0y0yfrk1F1xMu", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-11-09 21:34:22", last_sign_in_at: "2017-11-09 21:34:22", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "Linda", last_name: "Hickman", address: '15306 Highland Elm St', city: 'Houston', state_id: 44, country_id: 1, zip: 77433, active: nil, phone: nil, admin: true},
  {email: "tuantonyd@gmail.com", password: "password", password_confirmation: "password", encrypted_password: "$2a$11$/1.hscBy4kFsP/imQlfLde9g5DgX2V447yM/OcW7//OQ2yadQGyjy", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-11-09 22:13:06", last_sign_in_at: "2017-11-09 22:13:06", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "Tuan", last_name: "Do", address: "5000 Peace St.", city: "HOUSTON", state_id: 44, country_id: 1, zip: 77023, active: nil, phone: 8322024827, admin: false}])

(1..50).each do |n|
  order = Order.create!(total: rand(100..450), user_id: rand(1..3), order_status_id: 1,first_name: "Ethan", last_name: "Orcutt", address: "5000 Peace St.", city: "Houston", state_id: rand(1..50), country_id: 1, zip: 77004, created_at: "2017-#{rand(01..12)}-#{rand(01..20)}")
  OrderLine.create!(order: order, item_id: rand(1..12), qty: rand(1..20), order_line_status_id: 1)
end
