class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]

  def create
    file = LibraryFile.friendly.find(params[:library_file_id])

    @comment = Comment.new(comment_params.merge(user: current_user, library_file: file))

    if @comment.save
      redirect_to library_file_url(file)
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
