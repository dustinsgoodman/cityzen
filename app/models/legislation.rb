class Legislation < ActiveRecord::Base
  validates_presence_of :content, :date, :title, :num_for_votes, :num_no_votes
  attr_accessible :affected_location, :content, :date, :legislation_type, :district, :num_for_votes, :num_no_votes, :ordinance_id, :status, :sponsor, :title
  before_save :set_status

  has_one :post

  def summary
    [title, date, content, num_for_votes, num_no_votes, status, district].join " "
  end

  private
    def set_status
      self.status = self.num_for_votes > self.num_no_votes
    end
end
