module SocialMan
  module Configure
    # :like      symbole
    # Like       type
    # like       action (present_tense)  / like! like?
    # unlike     reverse action (un-)    / unlike! unlike?
    # liking_XX  subjects (progressive tense -ing) (liking_users)
    # liked_XX   objects (past_tense -ed) (liked_articles)
    # liker      all subjects (-er)
    # likable    all objects  (-able)
    
    @@actions = []

    def configure
      yield self if block_given?
    end

    def actions=(actions)
      actions.each { |action| @@actions << SocialMan::ActionThesaurus.new(action) }
    end

    def actions
      @@actions
    end

    def define_action(action, **options)
      @@actions << SocialMan::ActionThesaurus.new(action, options)
    end
  end
end
