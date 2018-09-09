require 'rails_helper'

RSpec.describe :ActionSubject do

  let(:user) { create :user }
  let(:article) { create :article }

  describe 'action' do
    before do
      user.take_action_on article
    end

    it "has a version number" do
      expect(user.active_to? article).to be true
      expect(article.active_to? user).to be true
    end
  end
end
