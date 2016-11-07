class BibleContent < ApplicationRecord
  belongs_to :bible, foreign_key: 'bible_bid'
end
