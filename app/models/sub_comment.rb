class SubComment < ActiveRecord::Base

  belongs_to :user
  belongs_to :comment

  attr_accessible :comment_id, :content, :user_id

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