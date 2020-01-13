FactoryBot.define do
  factory :post do
    text {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    user
    group
  end
end
