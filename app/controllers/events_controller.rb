class EventsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = Event.upcoming
  end

  def show
    @likers = @event.likers
    @categories = @event.categories

    if current_user
      @current_like = current_user.likes.find_by(event_id: @event)
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    if @event.save
      redirect_to @event, notice: "Event Successfully Updated!"
    else
      render :edit
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event Successfully Created!"
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, alert: "Event Successfully Destroyed!"
  end

  private
  
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :starts_at, :location, :price, :capacity, :image_file_name, category_ids: [])
  end

end
