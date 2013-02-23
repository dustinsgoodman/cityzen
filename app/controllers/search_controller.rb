class SearchController < ApplicationController

  def search(opts={})
    models = {
      "legislation" => Legislation,
      "petition" => Petition,
      "post" => Post
    }

    page = opts[:page] || 1
    per_page = opts[:per_page] || 25
    order = "_score:desc"

    search_params = {
      :query => params[:query],
      :index => params[:index],
      :type => params[:type],
      :page => page,
      :per_page => per_page,
      :order => order,
      :format => :active_record,
      :model_scope => models[params[:type]]
    }

    res = SiteSearch.new.search(search_params)
    @results = res[:records]

    respond_to do |format|
      format.html do
        render :action => 'index', :status => return_code
      end
      format.xml  { render :xml => @results }
    end
  end
end