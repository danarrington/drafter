class ReviewDraftFacade

  attr_accessor :draft_order, :draftables, :draft

  def initialize(draft_order, draftables, draft)
    @draft_order = draft_order
    @draftables = draftables
    @draft = draft
  end

end
