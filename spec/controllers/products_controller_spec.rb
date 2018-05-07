require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET show" do
    let!(:product) { create(:product) }
    it "assigns @product" do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
    it "renders the show template" do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end
end
