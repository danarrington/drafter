FactoryGirl.define do
  factory :draftable do
    sequence :name do |n|
      "#{Faker::Team.state}#{n}"
    end
    rank 1
  end

end
