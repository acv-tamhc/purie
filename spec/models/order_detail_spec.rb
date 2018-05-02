require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  let!(:order_detail) { create(:order_detail)}
  it { should validate_numericality_of(:quantity)}

  it 'Have get total' do
		order_detail.save!
		expect(order_detail.get_total).to be >= 0
	end
end
