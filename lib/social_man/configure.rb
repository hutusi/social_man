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

    def actions=(*actions)
      @@actions = actions
    end

    def actions
      @@actions
    end
  end
end
