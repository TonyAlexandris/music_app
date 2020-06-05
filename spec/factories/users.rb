FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    session_token { Faker::TvShows::VentureBros.quote }
    password {'qwerty'}
  end
end
