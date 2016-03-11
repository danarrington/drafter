class PickHandler

  def self.run(draft_id, draftable_id)
    draft = Draft.find(draft_id)
    unless draft.draftable_available(draftable_id)
      return false
    end

    handle_pick(draft, draftable_id)
  end

  private

  def.handle_pick(draft, draftable_id)
    pick = update_pick(draft.current_pick, draftable_id)
    make_auto_draft_picks
    #autodraft
    send_pick_made_emails(pick)
  end

  def self.update_pick(pick, draftable_id)
    draftable = Draftable.find(draftable_id)
    pick.update(draftable: draftable)
    pick
  end

  def self.send_pick_made_emails(pick)
    MailManager.send_pick_made_emails(pick)
  end

end
