FactoryGirl.define do
  factory :draft do
    name "A tournament"

    factory :draft_with_draftables do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
      end
    end
    factory :mid_draft_draft do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
        create_list(:player, 5, drafts: [draft])
        DraftOrderer.generate_or_retrieve_picks(draft)
        draft.picks.first.update(draftable: draft.draftables[0])
        draft.picks.second.update(draftable: draft.draftables[1])
      end
    end
  end

end
