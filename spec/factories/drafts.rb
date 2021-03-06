FactoryGirl.define do
  factory :draft do
    name "A tournament"

    factory :draft_with_draftables do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
      end
    end

    #A draft in the middle of the draft.  Perhaps not the best name ever.
    factory :mid_draft_draft do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
        create_list(:player, 5, drafts: [draft])
        DraftOrderer.generate_or_retrieve_picks(draft)
        draft.picks.first.update(draftable: draft.draftables[0])
        draft.picks.second.update(draftable: draft.draftables[1])
      end
    end

    #A draft near the end.
    factory :late_draft_draft do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
        create_list(:player, 5, drafts: [draft])
        DraftOrderer.generate_or_retrieve_picks(draft)
        draft.picks.each_with_index do |p, i|
          p.update(draftable: draft.draftables[i]) if (i < 18)
        end
      end
    end

    factory :last_pick_draft do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
        create_list(:player, 5, drafts: [draft])
        DraftOrderer.generate_or_retrieve_picks(draft)
        draft.picks.each_with_index do |p, i|
          p.update(draftable: draft.draftables[i]) if (i < 19)
        end
      end
    end

    factory :finished_draft do
      after(:create) do |draft|
        create_list(:draftable, 20, draft: draft)
        create_list(:player, 5, drafts: [draft])
        DraftOrderer.generate_or_retrieve_picks(draft)
        draft.picks.each_with_index do |p, i|
          p.update(draftable: draft.draftables[i]) if (i < 20)
        end
      end
    end
  end

end
