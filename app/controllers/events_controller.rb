class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = Event.all
  end

  def show
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
    redirect_to events_url, notice: "Event Successfully Destroyed!"
  end

  private
  
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :starts_at, :location, :price)
  end

end
