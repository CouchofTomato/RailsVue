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
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(comment_params)
      post = find_post(@comment)
      redirect_to post, notice: "Comment was updated."
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

  def find_post comment
    until comment.commentable.class == Post
      comment = comment.commentable
    end
    comment.commentable
  end

end
