require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) { create(:product) }
  it { should validate_presence_of(:item_code) }
  it { should validate_presence_of(:picture) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }

  it 'Can\'t be description than title' do
		product.save!
		expect(product.title_is_description_than_short).to eq nil
	end
end
