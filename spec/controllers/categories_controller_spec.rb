require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET index" do
    it "assigns @categories" do
      category = Category.create({title: 'Category', description: 'Category description'})
      get :index
      expect(assigns(:categories).first.title).to eq(category.title)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    let!(:category) { create(:category)}
    it "assign @category" do
      category = Category.create({title: 'Category', description: 'Category description'})
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
    end
    it "renders the show template" do
      get :show, params: { id: category.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end
end
