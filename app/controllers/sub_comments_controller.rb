class SubCommentsController < ApplicationController

  before_filter :load_sub_comment, :only => [:show, :edit, :update, :destroy]

  def new
    @sub_comment = SubComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ncomment }
    end
  end

  def create
    @sub_comment = SubComment.new(params[:sub_comment])

    respond_to do |format|
      if @sub_comment.save
        format.js
      end
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_comment }
    end
  end

  def destroy
    @sub_comment.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def load_sub_comment
    @sub_comment = SubComment.find(params[:sub_comments])
  end
end