class PetitionsController < ApplicationController
  def index
  end

  def new
    @petition = Petition.new
  end

  def create
    @petition = Petition.new params[:petition]

    if @petition.save
      flash[:notice] = "Petition successfully created!"
      redirect_to petitions_path
    else
      render :action => :new
    end
  end
end
