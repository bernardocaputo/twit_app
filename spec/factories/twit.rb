FactoryGirl.define do
 factory :twit do
   title         { FFaker::Lorem.words[1..15] }
   content   { FFaker::Tweet.tweet[1..140] }
   status { Twit.statuses.values.sample }
   user
 end
end
