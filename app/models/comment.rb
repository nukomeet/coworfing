class Comment
  include Mongoid::Document
  field :content 
  belongs_to :place, :inverse_of => :comments
  validates_presence_of :content

  belongs_to :user

end
