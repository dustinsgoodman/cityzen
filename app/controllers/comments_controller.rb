class CommentsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:update]
  before_filter :load_comment, :only => [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.js
      end
    end
  end

  def update
    if current_user && (current_user.admin? || current_user.moderator? || current_user == @comment.user)
      respond_to do |format|
        if @comment.update_attributes(params[:comment])
          @comment.update_attributes(:comment_updated_at => Time.current)
          @comment.save
          format.js
        end
      end
    end
  end

  def edit 
  end

  def show

    respond_to do |format|
      format.html {redirect_to @comment.post}
      format.json { render json: @comment }
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def load_comment
    @comment = Comment.find(params[:comment])
  end
end