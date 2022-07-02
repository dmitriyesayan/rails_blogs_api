class Api::V1::PostsController < Api::V1::BaseController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
