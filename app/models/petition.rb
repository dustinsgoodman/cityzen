class Petition < ActiveRecord::Base

  attr_accessible :title, :num_signatures, :num_goal, :author_id, :content, :user_id
  belongs_to :user
  has_many :signatures
  has_many :users, :through => :signatures


  def signatures_left
    num_goal - num_signatures
  end

end
