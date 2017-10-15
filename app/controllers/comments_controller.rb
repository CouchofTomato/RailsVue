class CommentsController < ApplicationController
	before_action :find_commentable
  before_action :set_comment, only: [:destroy]
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

    # The destroy action removes the comments permanently from the database
    def destroy
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
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

  #   def find_commentable
		#   params.each do |name, value|
		#     if name =~ /(.+)_id$/
		#       return $1.classify.constantize.find(value)
		#     end
		#   end
		#   nil
		# end

end