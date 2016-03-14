class AutoDrafter

  def self.run(draft)
    autopicks = []
    return autopicks if draft.is_over?
    while Autodraft.available_for(draft.current_pick) do
      autopicks << pick_auto_draft(draft.current_pick)
    end
    autopicks
  end

  private

  def self.pick_auto_draft(pick)
    available_draftable = Autodraft.available_for(pick).draftable
    pick.update(draftable: available_draftable, autodrafted: true)
    pick
  end

end
