FactoryGirl.define do
 factory :twit do
   content   { FFaker::Tweet.tweet[1..140] }
   user
 end
end
