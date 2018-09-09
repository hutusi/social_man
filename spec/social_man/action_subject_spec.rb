require 'rails_helper'

RSpec.describe :ActionSubject do

  let(:user) { create :user }
  let(:article) { create :article }

  describe 'action' do
    before do
      user.take_action_on article
    end

    it "active to article" do
      expect(user.active_to? article).to be true
      expect(article.passive_to? user).to be true
    end
  end

  describe 'like' do
    before do
      user.like article
    end

    it "active to article" do
      expect(user.like? article).to be true
      expect(user.liked_articles.count).to eq 1
      expect(user.liked_articles[0]).to eq article
    end
  end
end
