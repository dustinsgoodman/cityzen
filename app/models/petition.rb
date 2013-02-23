class Petition < ActiveRecord::Base

  attr_accessible :title, :num_signatures, :num_goal, :author_id, :content

  def signatures_left
    num_goal - num_signatures
  end

end
