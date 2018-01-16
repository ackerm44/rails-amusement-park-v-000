class AttractionsController <ApplicationController

  def index
    if logged_in?
      @attractions = Attraction.all
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def show
    if logged_in?
      @attraction = Attraction.find(params[:id])
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  private
  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end
end
