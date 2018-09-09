require 'rails_helper'

require 'social_man/action_thesaurus'

RSpec.describe :Action do
  describe 'default like' do
    subject { SocialMan::ActionThesaurus.new :like }
    its(:name) { should eq :like }
    its(:type) { should eq 'Like' }
    its(:action) { should eq 'like' }
    its(:undo) { should eq 'unlike' }
    its(:passive_action) { should eq 'liked_by' }
    its(:passive_undo) { should eq 'unliked_by' }
    its(:subjects_prefix) { should eq 'liking_' }
    its(:objects_prefix) { should eq 'liked_' }
    its(:all_subjects) { should eq 'likers' }
    its(:all_objects) { should eq 'likeables' }
  end

  describe 'with options like' do
    subject { SocialMan::ActionThesaurus.new :like, { undo: 'dislike', all_objects: 'likings' } }
    its(:name) { should eq :like }
    its(:type) { should eq 'Like' }
    its(:action) { should eq 'like' }
    its(:undo) { should eq 'dislike' }
    its(:passive_action) { should eq 'liked_by' }
    its(:passive_undo) { should eq 'unliked_by' }
    its(:subjects_prefix) { should eq 'liking_' }
    its(:objects_prefix) { should eq 'liked_' }
    its(:all_subjects) { should eq 'likers' }
    its(:all_objects) { should eq 'likings' }
  end

  describe 'default hack' do
    subject { SocialMan::ActionThesaurus.new :hack }
    its(:name) { should eq :hack }
    its(:type) { should eq 'Hack' }
    its(:action) { should eq 'hack' }
    its(:undo) { should eq 'unhack' }
    its(:passive_action) { should eq 'hacked_by' }
    its(:passive_undo) { should eq 'unhacked_by' }
    its(:subjects_prefix) { should eq 'hacking_' }
    its(:objects_prefix) { should eq 'hacked_' }
    its(:all_subjects) { should eq 'hackers' }
    its(:all_objects) { should eq 'hackables' }
  end

  describe 'with options hack' do
    subject { SocialMan::ActionThesaurus.new :hack, { undo: 'recover', subjects_prefix: 'hacked_' } }
    its(:name) { should eq :hack }
    its(:type) { should eq 'Hack' }
    its(:action) { should eq 'hack' }
    its(:undo) { should eq 'recover' }
    its(:passive_action) { should eq 'hacked_by' }
    its(:passive_undo) { should eq 'unhacked_by' }
    its(:subjects_prefix) { should eq 'hacked_' }
    its(:objects_prefix) { should eq 'hacked_' }
    its(:all_subjects) { should eq 'hackers' }
    its(:all_objects) { should eq 'hackables' }
  end

  describe 'default follow' do
    subject { SocialMan::ActionThesaurus.new :follow }
    its(:name) { should eq :follow }
    its(:type) { should eq 'Follow' }
    its(:action) { should eq 'follow' }
    its(:undo) { should eq 'unfollow' }
    its(:passive_action) { should eq 'followed_by' }
    its(:passive_undo) { should eq 'unfollowed_by' }
    its(:subjects_prefix) { should eq 'following_' }
    its(:objects_prefix) { should eq 'followed_' }
    its(:all_subjects) { should eq 'followers' }
    its(:all_objects) { should eq 'followees' }
  end

end
