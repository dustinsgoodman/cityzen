class Post < ActiveRecord::Base

  has_many :comments
  belongs_to :user
  belongs_to :petition
  belongs_to :legislation

  attr_accessible :content, :title, :user_id,
    :forum_id, :updated_at, :petition, :legislation, :comments_attributes

  validates_length_of :title, :minimum => 2
  validates_length_of :content, :minimum => 5

  before_save :test_whitespace

  accepts_nested_attributes_for :comments



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
