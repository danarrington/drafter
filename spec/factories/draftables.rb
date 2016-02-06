FactoryGirl.define do
  factory :draftable do
    name {Faker::Team.state}
    rank 1
  end

end
