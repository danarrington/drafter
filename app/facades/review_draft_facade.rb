class ReviewDraftFacade

  attr_accessor :draft_order, :draftables

  def initialize(draft_order, draftables)
    @draft_order = draft_order
    @draftables = draftables
  end

end
