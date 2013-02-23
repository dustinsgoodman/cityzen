client = ElasticSearch.new(
    '0.0.0.0:9200', 
    :index=> "legislations", 
    :type => "legislation"
)
#client.delete_index("legislations")
client.create_index("legislations")

client.update_mapping({
  :properties => {
    :legislation_id => {:type => :integer},
    :title => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :content => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :num_for_votes => {:type => :integer},
    :num_no_votes => {:type => :integer},
    :sponsor => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :date => {:type => :date},
    :status => {:type => :boolean},
    :district => {:type => :integer},
    :ordinance_id => {:type => :integer},
    :legislation_type => {:type => :integer},
    :created_at => {:type => :date},
    :updated_at => {:type => :date}
  }
}, :index => "legislations", :type => "legislation")

Legislation.find_each() { |l|
  client.index({
    :legislation_id => l[:id].to_i,
    :title => l[:title],
    :content => l[:content],
    :num_for_votes => l[:num_for_votes].to_i,
    :num_no_votes => l[:num_no_votes].to_i,
    :sponsor => l[:sponsor],
    :date => l[:date],
    :status => l[:status],
    :district => l[:district].to_i,
    :ordinance_id => l[:ordinance_id].to_i,
    :legislation => l[:legislation_type].to_i,
    :created_at => l[:created_at],
    :updated_at => l[:updated_at]
  }, :id => l[:id])
}