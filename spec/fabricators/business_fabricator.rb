Fabricator(:business) do
  name { Faker::Company.name }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state_abbr }
  zipcode { Faker::Address.zip }
  phone { Faker::PhoneNumber.cell_phone }
end