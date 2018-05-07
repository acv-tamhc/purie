require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    it "assigns @categories" do
      category = Category.create({title: 'Category', description: 'Category description'})
      get :index, {}
      expect(assigns(:categories).first.title).to eq(category.title)
      #assigns(:categories).should eq([category])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
