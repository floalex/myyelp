module ApplicationHelper
  def city_through_zip(business)
    business.city + ", " + business.state + " " + business.zipcode
  end
end
