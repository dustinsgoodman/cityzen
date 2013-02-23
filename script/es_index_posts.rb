client = ElasticSearch.new(
    '0.0.0.0:9200', 
    :index=> "posts", 
    :type => "post"
)
#client.delete_index("posts")
client.create_index("posts")

client.update_mapping({
  :properties => {
    :post_id => {:type => :integer},
    :title => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :content => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :user_id => {:type => :integer},
    :petition_id => {:type => :integer},
    :legislation_id => {:type => :integer},    
    :created_at => {:type => :date},
    :updated_at => {:type => :date}
  }
}, :index => "posts", :type => "post")

Post.find_each() {|p|
  client.index({
    :post_id => p[:id].to_i
    :title => p[:title],
    :content => p[:content]
    :user_id => p[:user_id].to_i,
    :petition_id => p[:petition_id].to_i,
    :legislation_id => p[:legislation_id].to_i
    :created_at => l[:created_at],
    :updated_at => l[:updated_at]
  }, :id => p[:id])
}