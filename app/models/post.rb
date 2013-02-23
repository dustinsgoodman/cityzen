class Post < ActiveRecord::Base

  has_many :comments
  belongs_to :user

  attr_accessible :content, :title, :user_id, 
    :forum_id, :post_updated_at, :petition, :legislation

  validates_length_of :title, :minimum => 2
  validates_length_of :content, :minimum => 5

  before_save :test_whitespace

  def self.search(search)
    if search
      where('title Like ?', '%#{search}%')
    else
      scoped
    end
  end

  private

  def test_whitespace
    if self.content.strip.length == 0
      self.content.length = 0
    end
  end
end