class Schedule < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true
  validates :reserved_at, :presence => true
end
