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

  def destroy(id)
    Autodraft.destroy(id)
    remaining_autodrafts = Autodraft.current_for(@draft, @player)
    refresh_order!(remaining_autodrafts)
  end

  private
  def refresh_order!(autodrafts)
    autodrafts.each.with_index(1) do |ad, i|
      ad.update_attribute(:order, i)
    end
  end



end
