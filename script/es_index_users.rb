client = ElasticSearch.new(
    Settings.elasticsearch.address, 
    :index=> "users", 
    :type => "user"
)
client.create_index("users")

client.update_mapping({
  :properties => {
    :user_id => {:type => :integer},
    :name => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :first_name => {:type => :string, :index => :not_analyzed},
    :last_name => {:type => :string, :index => :not_analyzed},
    :email => {:type => :string, :index => :not_analyzed},
    :login_count => {:type => :integer},
    :last_request => {:type => :date},
    :registered => {:type => :date}
  }
}, :index => "users", :type => "user")

User.find_each() { |u|
  client.index({
    :user_id => u[:id].to_i,
    :name => "#{u[:first_name]} #{u[:last_name]}",
    :first_name => u[:first_name].andand.downcase,
    :last_name => u[:last_name].andand.downcase,
    :email => u[:email].andand.downcase,
    :login_count => u[:login_count],
    :last_request => u[:last_request_at],
    :registered => u[:created_at]
  }, :id => u[:id])
}

elasticsearch:
    binpath: /usr/local/bin
    log_file: "/usr/local/var/log/elasticsearch/es_cityzen.log"
    cluster_path: /usr/local/var/elasticsearch/es_cityzen/
    port: 9200
    listen: 9200
    address: '0.0.0.0:9200'