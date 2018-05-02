require 'rails_helper'

RSpec.describe Order, type: :model do
	let!(:order) { create(:order) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:phone) }
	it { should validate_presence_of(:address) }
end
