FactoryGirl.define do
 factory :twit do
   title         { FFaker::Lorem.word }
   content   { FFaker::Lorem.sentence }
   status { Twit.statuses.values.sample }
   user
 end
end
