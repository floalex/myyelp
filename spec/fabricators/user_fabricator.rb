Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name }
  zipcode { Faker::Address.zip.first(5) }
end