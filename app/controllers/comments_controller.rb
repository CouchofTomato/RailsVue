class CommentsController < ApplicationController
	before_action :find_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new(comment_params)

      if @comment.save
        redirect_back(fallback_location: root_path, notice: 'Your comment was successfully posted!') 
      else
        redirect_back(fallback_location: root_path, notice: "Your comment wasn't posted!") 
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

  #   def find_commentable
		#   params.each do |name, value|
		#     if name =~ /(.+)_id$/
		#       return $1.classify.constantize.find(value)
		#     end
		#   end
		#   nil
		# end

end