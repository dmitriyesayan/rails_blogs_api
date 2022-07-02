class Api::V1::PostsController < Api::V1::BaseController
  before_action :set_post, only: [ :show, :update ]

  def index
    @posts = Post.all
  end

  def show
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def render_error
    render json: { errors: @post.errors.full_messages },
     status: :unprocessable_entity
  end

end
