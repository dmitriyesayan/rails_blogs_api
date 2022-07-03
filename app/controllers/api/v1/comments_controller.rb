class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [ :show, :update, :destroy ]

  def index
    @comments = Comment.where(post_id: params[:post_id])
  end

  def show
  end

  def update
    if @comment.update(comment_params)
      render :show
    else
      render_error
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      render :show
    else
      render_error
    end
  end

  def destroy
    if @comment.destroy
      head :no_content
    else
      render_error
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(post_id: params[:post_id], id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
     status: :unprocessable_entity
  end

end
