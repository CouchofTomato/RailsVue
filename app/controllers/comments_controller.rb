class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_back(fallback_location: root_path, notice: 'Your comment was successfully posted!') 
    else
      redirect_back(fallback_location: root_path, notice: "Your comment wasn't posted!") 
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
    @comment = @commentable.comments.find(params[:id])
  end

  def update
    @comment = @commentable.comments.find(params[:id])

    if @comment.update_attributes(comment_params)
      redirect_to @comment.commentable, notice: "Comment was updated."
    else
      render :edit
    end
  end

  # The destroy action removes the comments permanently from the database
  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Successfully deleted comment!"
      redirect_to root_path
    else
      flash[:alert] = "Error updating comment!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end


  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable = $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
