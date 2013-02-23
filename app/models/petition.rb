class Petition < ActiveRecord::Base

  attr_accessible :title, :num_signatures, :num_goal, :content, :user_id, :post_attributes


  belongs_to :user
  has_many :signatures
  has_many :users, :through => :signatures
  has_one :post

  accepts_nested_attributes_for :post

  def signatures_left
    num_goal - num_signatures
  end

end
