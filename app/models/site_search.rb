class SiteSearch
  
  attr_accessor :query
  
  def initialize
  end
  
  def build_query
    search_specs = []
    
    EsSearch::QueryBuilder.build_query {|q|
      search_specs << q.text(:title, @query)
      search_specs << q.text(:content, @query)
      
      q.bool(:should, *search_specs.flatten)
    }
  end
  
  def build_filter
    filter_specs = []
    
    EsSearch::FilterBuilder.build_filter {|f|
      Rails.logger.debug "Filtering object: #{self.inspect}"

      if !filter_specs.empty?
        f.and(*filter_specs.flatten)
      else
        nil
      end
    }
  end
  
  def search(search_params)
    @query = search_params[:query]
    search_query = EsSearch.new(
      :index => search_params[:index],
      :type => search_params[:type],
      :query => build_query,
      :filter => build_filter,
      :model_scope => search_params[:model_scope]
    )
    
    res = search_query.search(
      :per_page => search_params[:per_page], 
      :page => search_params[:page],
      :order => search_params[:order],
      :format => search_params[:format]
    )
  end
end