class Response < ApplicationRecord
  belongs_to :user

  scope :find_by_user, -> (user_id) { where("user_id = ?", user_id) }
end
