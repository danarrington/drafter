FactoryGirl.define do
  factory :draft do
    name "A tournament"

    factory :draft_with_draftables do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
      end
    end
  end

end
