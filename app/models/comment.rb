class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :place
  
  delegate :username, to: :user

  validates :content, length: { in: 5..500 }, presence: true
  validates :user, :place, presence: true
end
