class Admin::ForumsController < Admin::AdminController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  def show
    @threads = @forum.threads.ordered
  end

  private

    def set_forum
      @forum = Forum.find(params[:id])
    end

    def forum_params
      params.require(:forum).permit(:name, :description)
    end
end
