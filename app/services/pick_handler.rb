class PickHandler

  def self.run(draft_id, draftable_id)
    draft = Draft.find(draft_id)
    unless draft.draftable_available(draftable_id)
      return false
    end

    update_pick_and_send_emails(draft.current_pick, draftable_id)

  end

  private

  def self.update_pick_and_send_emails(pick, draftable_id)
    draftable = Draftable.find(draftable_id)
    pick.update(draftable: draftable)
    send_pick_made_emails(pick)
  end

  def self.send_pick_made_emails(pick)
    MailManager.send_pick_made_emails(pick)
  end

end
