class AutoDraftRepository

  def initialize(draft, player)
    @draft = draft
    @player = player
  end

  def save(draftable)
    existing_autodrafts = Autodraft.current_for(@draft, @player)
    refresh_order!(existing_autodrafts)
    Autodraft.create(draft: @draft, draftable: draftable, player: @player,
                     order: existing_autodrafts.count+1)
  end

  private
  def refresh_order!(existing_autodrafts)
    existing_autodrafts.each.with_index(1) do |ad, i|
      ad.update_attribute(:order, i)
    end
  end



end
