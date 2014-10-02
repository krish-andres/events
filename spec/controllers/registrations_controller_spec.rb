require 'spec_helper' 

describe RegistrationsController do
  before { @event = Event.create!(event_attributes) } 

  context "when not signed in" do
    before { session[:user_id] = nil } 

    it "cannot access index" do
      get :index, event_id: @event
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access new" do
      get :new, event_id: @event
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access create" do
      post :create, event_id: @event
      expect(response).to redirect_to(signin_url)
    end
  end
end
