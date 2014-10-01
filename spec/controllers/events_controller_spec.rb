require 'spec_helper'

describe EventsController do
  before { @event = Event.create!(event_attributes) } 

  context "when not signed in as an admin user" do
    before do
      non_admin = User.create!(user_attributes(admin: false))
      session[:user_id] = non_admin.id
    end

    it "cannot access new" do
      get :new
      expect(response).to redirect_to(root_url)
    end

    it "cannot access create" do
      post :create
      expect(response).to redirect_to(root_url)
    end

    it "cannot access edit" do
      get :edit, id: @event
      expect(response).to redirect_to(root_url)
    end

    it "cannot access update" do
      patch :update, id: @event
      expect(response).to redirect_to(root_url)
    end
    
    it "cannot access destroy" do
      delete :destroy, id: @event
      expect(response).to redirect_to(root_url)
    end
  end
end
