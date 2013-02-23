class Comment < ActiveRecord::Base

  has_many :sub_comments
  belongs_to :post
  belongs_to :user

  attr_accessible :content, :user_id, :post_id

  validates_presence_of :content
  validates_length_of :content, :minimum => 1

  before_save :test_whitespace

  private

  def test_whitespace
    if self.content.strip.length == 0
      self.content.length = 0
    end
  end
  
end