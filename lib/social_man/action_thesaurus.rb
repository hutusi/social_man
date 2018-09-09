# frozen_string_literal: true

    # :like      symbole, action
    # Like       type
    # like       do action (present_tense)  / like! like?
    # unlike     undo action (un-)    / unlike! unlike?
    # liked_by   passive do action (-ed_by)  / liked_by! liked_by?
    # unliked_by passive undo action (un-*-ed_by)    / unliked_by! unliked_by?
    # liking_XX  subjects_prefix (progressive tense -ing_) (liking_user, liking_users)
    # liked_XX   objects_prefix (past_tense -ed_) (liked_article, liked_articles)
    # likers     all subjects (-ers) liker, all likers
    # likables   all objects  (-ables) likable, all likables

module SocialMan
  class ActionThesaurus
    attr_reader :name, :type, :action, :undo, :passive_action, :passive_undo,
                :subjects_prefix, :objects_prefix, :all_subjects, :all_objects

    def initialize(action_name, options={})
      @name = action_name.to_sym
      name = action_name.to_s
      @type = options_or_thesaurus(options, :type) || name.camelize
      @action = options_or_thesaurus(options, :action) || name
      @undo = options_or_thesaurus(options, :undo) || 'un' + name
      @passive_action = options_or_thesaurus(options, :passive_action) || name + 'ed_by'
      @passive_undo = options_or_thesaurus(options, :passive_undo) || 'un' + name + + 'ed_by'
      @subjects_prefix = options_or_thesaurus(options, :subjects_prefix) || name + 'ing_'
      @objects_prefix = options_or_thesaurus(options, :objects_prefix) || name + 'ed_'
      @all_subjects = options_or_thesaurus(options, :all_subjects) || name + 'ers'
      @all_objects = options_or_thesaurus(options, :all_objects) || name + 'ables'
    end

    private 

    def options_or_thesaurus(options, key)
      options[key].presence || fetch_thesaurus(@name, key)
    end

    def fetch_thesaurus(action_name, key)
      action = ActionThesaurus.thesaurus[action_name]
      action.nil? ? nil : action[key]
    end

    class << self
      def thesaurus
        @@thesaurus ||= init_thesaurus
      end

      def init_thesaurus
        thesaurus_array = [
          %w(like unlike liked_by unliked_by liking liked liker likeable),
          %w(star unstar starred_by unstarred_by starring starred starrer starable),
          %w(block unblock blocked_by unblocked_by blocking blocked blockers blockable),
          %w(follow unfollow followed_by unfollowed_by following followed follower followee),
          %w(vote unvote voted_by unvoted_by voting voted voter votable)
        ]

        thesaurus = {}
        thesaurus_array.each do |line|
          thesaurus[line[0].to_sym] = {
            name: line[0].to_sym, 
            type: line[0].camelize,
            action: line[0],
            undo: line[1],
            passive_action: line[2],
            passive_undo: line[3],
            subjects_prefix: line[4] + '_',
            objects_prefix: line[5] + '_',
            all_subjects: line[6].pluralize,
            all_objects: line[7].pluralize
          }
        end

        thesaurus
      end
    end
  end
end
