require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "shows all a users ticket's if logged in" do
      user = create(:user)
      session[:user_id] = user.id
      get :index, params: {user_id: user.id}
      expect(response.status).to eq(200)
    end
    it "redirects to concerts index if not logged in" do
     get :index, params: {user_id: 0}
     expect(response).to redirect_to('/signin')
    end
  end

  describe "POST #create" do
    it "creates a new ticket for a concert and a user when a user is logged in" do
      user = create(:user)
      session[:user_id] = user.id
      concert = create(:concert)
      expect{
              create(:ticket, user_id: 1, concert_id: 1)
            }.to change(Ticket, :count).by(1)
    end
  end
end