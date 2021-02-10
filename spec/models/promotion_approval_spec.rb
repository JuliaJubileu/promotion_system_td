require 'rails_helper'

RSpec.describe PromotionApproval, type: :model do
  describe '#valid?' do
    context 'different user' do 
      it 'is different' do
        creator = User.create!(email: 'julia@dev.com', password: '123456')
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
        expiration_date: '22/12/2033', user: creator)
        approver = User.create!(email: 'joao@dev.com', password: 'fAk3pA55w0rD')

        approval = PromotionApproval.new(promotion: promotion, user: approver)

        result = approval.valid?

        expect(result).to eq true
      end
    
      it 'Is the same user' do
        creator = User.create!(email: 'julia@dev.com', password: '123456')
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
        expiration_date: '22/12/2033', user: creator)
        approver = User.create!(email: 'joao@dev.com', password: 'fAk3pA55w0rD')

        approval = PromotionApproval.new(promotion: promotion, user: creator)

        result = approval.valid?

        expect(result).to eq false
      end
      it 'has no promotion or user' do
        approval = PromotionApproval.new()

        result = approval.valid?

        expect(result).to eq false
      end
    end
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> af97c791456378dc41b8fec153ac32d908243764
