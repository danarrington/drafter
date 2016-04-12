FactoryGirl.define do
  factory :autodraft do
    draft nil
    player nil
    draftable nil
    order 1

    factory :autodraft_for_current_picker do
      order 1
      after(:create) do |a|
        a.player = a.draft.current_pick.player
        a.draftable = a.draft.remaining_draftables.first
        a.save
      end
    end
  end

end
