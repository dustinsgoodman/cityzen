client = ElasticSearch.new(
    '0.0.0.0:9200', 
    :index=> "petitions", 
    :type => "petition"
)
#client.delete_index("petitions")
client.create_index("petitions")

client.update_mapping({
  :properties => {
    :petition_id => {:type => :integer},
    :title => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :num_signatures => {:type => :integer},
    :user_id => {:type => :integer},
    :num_goal => {:type => :integer},
    :geo => {:type => :geo_point, :lat_lon => :true, :geohash => :true},
    :content => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :created_at => {:type => :date},
    :updated_at => {:type => :date}
  }
}, :index => "petitions", :type => "petition")

Petition.find_each() {|p|
  client.index({
    :petition_id => p[:id].to_i,
    :title => p[:title],
    :num_signatures => p[:num_signatures],
    :user_id => p[:user_id].to_i,
    :num_goal => p[:num_goal].to_i,
    :geo => [p[:longitude], p[:latitude]],
    :content => p[:content],
    :created_at => p[:created_at],
    :updated_at => p[:updated_at]
  }, :id => p[:id])
}