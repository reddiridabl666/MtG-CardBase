require 'rails_helper'

RSpec.describe "Main", type: :request do
  describe "GET /index" do
    it 'responds with correct pages of cards' do
      get root_path

      expect(response).to have_http_status(:ok)
      first_cards = assigns(:cards)
      expect(first_cards.size).to eq CardInstance.page(1).limit_value

      get root_path, params: { page: 3 }
      expect(assigns(:cards)).not_to eq first_cards
      expect(assigns(:cards).size).to eq CardInstance.page(1).limit_value
    end
  end
end
