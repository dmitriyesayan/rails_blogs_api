class Api::V1::PostsController < Api::V1::BaseController
  before_action :set_post, only: [ :show, :update, :destroy ]

  def index
    @posts = Post.order(position: :asc)
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

  def create
    @post = Post.new(post_params)
    if @post.save
      render :show
    else
      render_error
    end
  end

  def destroy
    if @post.destroy
      head :no_content
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
