class Api::V1::SubcommentsController < Api::V1::BaseController
  before_action :set_subcomment, only: [ :show, :update, :destroy ]

  def show
  end

  def update
    if @subcomment.update(subcomment_params)
      # render Posts controller#show
      render :show
    else
      render_error
    end
  end

  def create
    @subcomment = Subcomment.new(subcomment_params)
    @subcomment.comment_id = params[:comment_id]
    if @subcomment.save
      # render Posts controller#show
      render :show
    else
      render_error
    end
  end

  def destroy
    if @subcomment.destroy
      head :no_content
    else
      render_error
    end
  end

  private

  def set_subcomment
    @subcomment = Subcomment.find(params[:id])
  end

  def subcomment_params
    params.require(:subcomment).permit(:content)
  end

  def render_error
    render json: { errors: @subcomment.errors.full_messages },
     status: :unprocessable_entity
  end

end
