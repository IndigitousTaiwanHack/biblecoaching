class Rank < ApplicationRecord
  validates_uniqueness_of :user_id, :scope => [:rank_type, :object_id]
  scope :by_type_and_id, -> (rank_type,object_id) { where("rank_type = ? and object_id=?", rank_type,object_id) }
  scope :by_user, -> (user_id) { where("user_id = ?", user_id) }
end
