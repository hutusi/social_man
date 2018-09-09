require 'rails_helper'

RSpec.describe :ActionObject do

  let(:user) { create :user }
  let(:article) { create :article }
  let(:comments) { create_list :comment, 5 }

  let(:john) { create :john }
  let(:sam) { create :sam }

  describe 'action' do
    before do
      article.taken_action_by user
    end

    it "active to article" do
      expect(user.active_to? article).to be true
      expect(article.passive_to? user).to be true
    end
  end

  describe 'like' do
    before do
      article.liked_by user
    end

    it "active to article" do
      expect(user.like? article).to be true
      expect(user.liked_articles.count).to eq 1
      expect(user.liked_articles[0]).to eq article

      expect(article.liked_by? user).to be true
      expect(article.liking_users.count).to eq 1
      expect(article.liking_users[0]).to eq user
    end
  end

  describe 'unlike' do
    before do
      article.liked_by user
      article.unliked_by user
    end

    it "active to article" do
      expect(user.like? article).to be false
      expect(user.unlike? article).to be true
      expect(user.liked_articles.count).to eq 0

      expect(article.liked_by? user).to be false
      expect(article.unliked_by? user).to be true
      expect(article.liking_users.count).to eq 0
    end
  end

  describe 'like many' do
    before do
      article.liked_by user
      article.liked_by john
      comments[0].liked_by user
      comments[1].liked_by user
    end

    it "active to article" do
      expect(user.like? article).to be true
      expect(user.liked_articles.count).to eq 1
      expect(user.liked_comments.count).to eq 2

      expect(article.liked_by? user).to be true
      expect(article.liking_users.count).to eq 2
      expect(comments[0].liking_users.count).to eq 1
    end
  end

  describe 'Follow' do
    before do
      john.followed_by sam
    end

    it "active to article" do
      expect(john.followed_by? sam).to be true
      expect(john.following_users.count).to eq 1
      expect(john.following_users[0]).to eq sam

      expect(sam.follow? john).to be true
      expect(sam.followed_users.count).to eq 1
      expect(sam.followed_users[0]).to eq john
    end
  end
end
