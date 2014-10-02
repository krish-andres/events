class LikesController < ApplicationController
  before_action :require_signin
  before_action :set_event

  def create
    @event.likes.create!(user: current_user)
    redirect_to @event
  end

  def destroy
    current_like = current_user.likes.find(params[:id])
    current_like.destroy
    redirect_to @event
  end

  private
  
  def set_event
    @event = Event.find(params[:event_id])
  end
end
