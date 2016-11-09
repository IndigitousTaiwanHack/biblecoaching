class Post < ApplicationRecord
  has_many :responses
  belongs_to :user
  belongs_to :bible, foreign_key: 'bible_bid'

  scope :find_by_user, -> (user_id) { where("user_id = ?", user_id) }
  scope :find_by_bible_bid, -> (bible_bid) { where("bible_bid = ?", bible_bid) }

  def self.popular
    return self.joins(:responses)
          .select("posts.*, count(responses.id) as count")
          .group("posts.id")
          .order("count DESC").first
  end
end
