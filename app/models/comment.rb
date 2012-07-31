class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, length: { in: 5..500 }, presence: true
end
