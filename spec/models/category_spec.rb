require 'rails_helper'

RSpec.describe Category, type: :model do
	let!(:category) { create(:category) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }
end
