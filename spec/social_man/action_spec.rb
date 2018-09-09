require 'rails_helper'

require 'social_man/action_thesaurus'

RSpec.describe :Action do
  describe 'default like' do
    subject { SocialMan::ActionThesaurus.new :like }
    its(:name) { should eq :like }
    its(:type) { should eq 'Like' }
    its(:action) { should eq 'like' }
    its(:undo) { should eq 'unlike' }
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
    its(:subjects_prefix) { should eq 'hacked_' }
    its(:objects_prefix) { should eq 'hacked_' }
    its(:all_subjects) { should eq 'hackers' }
    its(:all_objects) { should eq 'hackables' }
  end

end
