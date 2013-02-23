class PetitionsController < ApplicationController

  before_filter :require_user, :only => [:new, :create, :update, :destroy]
  before_filter :require_no_user, :only => [:index, :show]

  def index
    @petitions = Petition.all
  end

  def new
    @petition = Petition.new
  end

  def show
    @petition = Petition.find(params[:id])
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

  def sign
    @petition = Petition.find(params[:petition_id])

    @petition.users << current_user

    redirect_to petition_path(@petition)
  end
end
