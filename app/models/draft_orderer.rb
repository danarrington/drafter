class DraftOrderer

  def self.generate_or_retrieve_picks(draft)
    unless(draft.picks.any?)
      generate_picks(draft)
    end

    draft.picks.collect(&:player)
  end

  private

  def self.generate_picks(draft)
    snake_draft_order = generate_snake_order(draft)
    draft.draftables.each_with_index do |d, i|
      next_drafter = snake_draft_order[i%snake_draft_order.count]
      Pick.create(number: i, player: next_drafter, draft: draft)
    end
  end

  # 1, 2, 3, 3, 2, 1
  def self.generate_snake_order(draft)
    draft_order = draft.players.shuffle
    draft_order + draft_order.reverse
  end
end
