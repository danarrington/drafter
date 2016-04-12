require 'rails_helper'

RSpec.describe AutodraftsController, type: :controller do

  describe "DELETE #destroy" do
    let!(:draft) {create(:mid_draft_draft)}
    let!(:autodraft) {create(:autodraft_for_current_picker, draft: draft)}
    before {sign_in draft.current_pick.player}
    it "deletes the autodraft" do
      expect {
        delete :destroy, id: autodraft.id
      }.to change(Autodraft, :count).by(-1)

    end

    describe "For an autodraft that does not belong to the player" do
      let(:another_player) {draft.most_recently_made_pick.player}
      before {sign_in another_player}

      it "should not delete the autodraft" do
        expect {
          delete :destroy, id: autodraft.id
        }.to change(Autodraft, :count).by(0)
      end
    end

  end

end
