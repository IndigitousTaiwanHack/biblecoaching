class User < ApplicationRecord
  has_many :posts
  has_many :responses
  has_many :user_likes

  scope :find_by_uid, -> (uid) { where("uid = ?", uid) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.save!
    end
  end

  def self.find_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end

  def self.find_by_api(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first
  end

  def self.from_api(auth)
    return 1 if where(provider: auth[:provider], uid: auth[:uid]).first
    user = User.new(auth)
    if user.save
      return 0
    end
    return -1
  end

  def get_focus_users
    users = []
    self.user_likes.each do |u|
      users << User.find(u.to_user_id)
    end
    return users
  end
end
