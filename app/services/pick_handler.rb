class PickHandler

  def self.run(draft_id, draftable_id)
    draft = Draft.find(draft_id)
    unless draft.draftable_available(draftable_id)
      return false
    end

    handle_pick(draft, draftable_id)
  end

  private

  def self.handle_pick(draft, draftable_id)
    picks = [update_pick(draft.current_pick, draftable_id)]
    picks += AutoDrafter.run(draft)
    send_pick_made_emails(picks)
  end

  def self.update_pick(pick, draftable_id)
    draftable = Draftable.find(draftable_id)
    pick.update(draftable: draftable)
    pick
  end

  def self.send_pick_made_emails(picks)
    MailManager.send_pick_made_emails(picks)
  end

end
