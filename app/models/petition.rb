class Petition < ActiveRecord::Base

  attr_accessible :title, :num_signatures, :num_goal, :content, :user_id


  belongs_to :user
  has_many :signatures
  has_many :users, :through => :signatures
  has_one :post

  def signatures_left
    num_goal - num_signatures
  end

end
