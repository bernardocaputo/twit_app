FactoryGirl.define do
 factory :user do
   username         { FFaker::Lorem.word }
   email        { FFaker::Internet.email }
   password     'secret123'
 end
end
