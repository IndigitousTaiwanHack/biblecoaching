class Bible < ApplicationRecord
  self.primary_key= :bid
  belongs_to :book
  has_many :bible_contents, foreign_key: 'bible_bid'
  has_many :posts, foreign_key: 'bible_bid'

  scope :find_by_book, -> (book_id) { where("book_id = ?", book_id) }

  def self.find_by_bid(bid)
    self.where(bid: bid).first
  end

  def self.popular
    return self.joins(:posts)
               .select("bibles.bid, bibles.book_id,count(posts.id) as count")
               .group("posts.bible_bid")
               .order("count DESC").first
  end
end
