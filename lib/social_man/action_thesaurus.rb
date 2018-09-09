# frozen_string_literal: true

    # :like      symbole, action
    # Like       type
    # like       do action (present_tense)  / like! like?
    # unlike     undo action (un-)    / unlike! unlike?
    # liking_XX  subjects_prefix (progressive tense -ing_) (liking_user, liking_users)
    # liked_XX   objects_prefix (past_tense -ed_) (liked_article, liked_articles)
    # likers     all subjects (-ers) liker, all likers
    # likables   all objects  (-ables) likable, all likables

module SocialMan
  class ActionThesaurus
    attr_reader :name, :type, :action, :undo, :subjects_prefix, :objects_prefix,
                :all_subjects, :all_objects

    def initialize(action_name, options={})
      @name = action_name.to_sym
      name = action_name.to_s
      @type = options_or_thesaurus(options, :type) || name.camelize
      @action = options_or_thesaurus(options, :action) || name
      @undo = options_or_thesaurus(options, :undo) || 'un' + name
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
          %w(like unlike liking liked liker likeable),
          %w(star unstar starring starred starrer starable),
          %w(block unblock blocking blocked blockers blockable),
          %w(follow unfollow following followed follower followee),
          %w(vote unvote voting voted voter votable)
        ]

        thesaurus = {}
        thesaurus_array.each do |line|
          thesaurus[line[0].to_sym] = {
            name: line[0].to_sym, 
            type: line[0].camelize,
            action: line[0],
            undo: line[1],
            subjects_prefix: line[2] + '_',
            objects_prefix: line[3] + '_',
            all_subjects: line[4].pluralize,
            all_objects: line[5].pluralize
          }
        end

        thesaurus
      end
    end
  end
end
