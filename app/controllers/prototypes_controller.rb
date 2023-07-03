class PrototypesController < ApplicationController

  # private
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:prototype, keys: [:title, :catch_copy, :concept, :image ])
  #   .merge(user_id: current_user.id)
  # end
  # def index
  #   @prototype = Prototype.new
  #   render :new
  # end
  def index
    @prototypes = Prototype.joins(:user)

  end

  def show
    @prototype = Prototype.joins(:user).find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(prototype_id: params[:id]).includes(:user)
 
    # @comments = @prototype.comments.includes(:prototype)

  end

  def new
    if !authenticate_user!
      redirect_to new_user_session_path
    end
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    # prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    if !authenticate_user!
      redirect_to new_user_session_path
    end
    
    @prototype = Prototype.joins(:user).find(params[:id])
    if current_user.id != @prototype.user.id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.joins(:user).find(params[:id])

    if (@prototype.update(prototype_params))
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
    
  end

  def destroy
    if !authenticate_user!
      redirect_to new_user_session_path
    end
    @prototype = Prototype.joins(:user).find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
