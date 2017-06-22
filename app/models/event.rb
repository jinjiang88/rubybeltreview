class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validate :futuredate #################### tells it to validate
  has_many :event_users
  has_many :users_comments, through: :comments, source: :user
  has_many :users, through: :event_users
  validates :name, :date, :location, :state, presence: true

  def futuredate ################## this is the method you built
    if date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
