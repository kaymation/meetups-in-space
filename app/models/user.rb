class User < ActiveRecord::Base
  has_many :meetup_users
  has_many :meetups, through: :meetup_users

  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.provider = provider
      user.uid = uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  def join(meetup)
    meetups << meetup
  end

  def leave(meetup)
    meetup_users.where(meetup: meetup).delete_all
  end

  def is_going?(meetup)
    meetups.include?(meetup)
  end
end
