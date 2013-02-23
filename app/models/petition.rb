class Petition < ActiveRecord::Base

  attr_accessible :title, :num_signatures, :num_goal, :author_id, :content

end
