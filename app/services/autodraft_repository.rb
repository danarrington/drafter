class AutodraftRepository

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

  def move(id, direction)
    autodraft = Autodraft.find(id)
    autodrafts = Autodraft.current_for(@draft, @player)
    swap_autodraft(autodraft, autodrafts, direction)
    refresh_order!(autodrafts)
  end

  private
  def refresh_order!(autodrafts)
    autodrafts.each.with_index(1) do |ad, i|
      ad.update_attribute(:order, i)
    end
  end

  def swap_autodraft(autodraft_to_move, autodrafts, direction)
    if direction.to_sym == :up
      swap_autodraft_up(autodraft_to_move, autodrafts)
    else
      swap_autodraft_down(autodraft_to_move, autodrafts)
    end
  end

  def swap_autodraft_up(autodraft_to_move, autodrafts)
    index = autodrafts.index(autodraft_to_move)
    autodrafts[index], autodrafts[index-1] = autodrafts[index-1], autodrafts[index]
  end

  def swap_autodraft_down(autodraft_to_move, autodrafts)
    index = autodrafts.index(autodraft_to_move)
    autodrafts[index], autodrafts[index+1] = autodrafts[index+1], autodrafts[index]
  end
end
