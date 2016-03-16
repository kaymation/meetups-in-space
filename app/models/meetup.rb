class Meetup < ActiveRecord::Base
  has_many :meetup_users
  has_many :users, through: :meetup_users
  validates_length_of :name, maximum: 100
  validates_length_of :details, minimum: 20
  validates :when, presence: true
  validates :location, presence: true

  def owner
    meetup_users.find_by(owner: true).user
  end

  def owner=(owner)
    MeetupUser.create(meetup: self, user: owner, owner: true)
  end
end
