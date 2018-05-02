require 'rails_helper'

RSpec.describe Category, type: :model do
	let!(:category) { create(:category) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }
	it { should have_many(:product) }

	it 'Can\'t be description than title' do
		category.save!
		expect(category.title_is_description_than_short).to eq nil
	end
end
