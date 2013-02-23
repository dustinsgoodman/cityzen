class Legislation < ActiveRecord::Base
  attr_accessible :affected_location, :content, :date, :legislation_type, :num_for_votes, :num_no_votes, :ordinance_id, :passed?, :sponsor, :title
end
