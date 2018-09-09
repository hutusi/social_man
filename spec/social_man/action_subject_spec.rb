require 'rails_helper'

RSpec.describe :ActionSubject do

  let(:user) { create :user }
  let(:article) { create :article }
  let(:comments) { create_list :comment, 5 }

  let(:john) { create :john }
  let(:sam) { create :sam }

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

  describe 'unlike' do
    before do
      user.like article
      user.unlike article
    end

    it "active to article" do
      expect(user.like? article).to be false
      expect(user.unlike? article).to be true
      expect(user.liked_articles.count).to eq 0
    end
  end

  describe 'like many' do
    before do
      user.like article
      user.like comments[0]
      user.like comments[1]
    end

    it "active to article" do
      expect(user.like? article).to be true
      expect(user.liked_articles.count).to eq 1
      expect(user.liked_comments.count).to eq 2
    end
  end

  describe 'Follow' do
    before do
      john.follow sam
    end

    it "active to article" do
      expect(john.follow? sam).to be true
      expect(john.followed_users.count).to eq 1
      expect(john.followed_users[0]).to eq sam
    end
  end
end
