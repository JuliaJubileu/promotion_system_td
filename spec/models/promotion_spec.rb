require 'rails_helper'

describe Promotion do
  context 'validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new

      expect(promotion.valid?).to eq false
      expect(promotion.errors.count).to eq 6
    end

    it 'description is optional' do
      user = User.create!(email: 'julia@dev.com', password: '123456')
      promotion = Promotion.new(name: 'Natal', description: '', code: 'NAT',
                                coupon_quantity: 10, discount_rate: 10,
                                expiration_date: '2021-10-10', user: user)

      expect(promotion.valid?).to eq true
    end

    it 'error messages are in portuguese' do
      promotion = Promotion.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be uniq' do
      user = User.create!(email: 'julia@dev.com', password: '123456')
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('já está em uso')
    end
  end
  context 'generate_coupons!' do
    it 'generate coupons of coupon_quantity' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)

    promotion.generate_coupons!

    expect(promotion.coupons.size).to eq(100)
    codes = promotion.coupons.pluck(:code)
    expect(codes).to include('NATAL10-0001')
    expect(codes).to include('NATAL10-0100')
    expect(codes).not_to include('NATAL10-0000')
    expect(codes).not_to include('NATAL10-0101')
    end

    it 'do not generate if error' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    promotion.coupons.create!(code: 'NATAL10-0030')

    expect(promotion.coupons.reload.size).to eq(1)
    end
  end
  context 'approve!' do
    it 'should generate PromotionApproval object' do 
      creator = User.create!(email: 'julia@dev.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033', user: creator)
      approver = User.create!(email: 'joao@dev.com', password: 'fAk3pA55w0rD')

      promotion.approve!(approver)
      
      promotion.reload
      expect(promotion.approved?).to be_truthy
      expect(promotion.approver).to eq(approver)
    end
    it 'should not be the same user' do
      creator = User.create!(email: 'julia@dev.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033', user: creator)
      approver = User.create!(email: 'joao@dev.com', password: 'fAk3pA55w0rD')

      promotion.approve!(creator)
      
      promotion.reload
      expect(promotion.approved?).to be_falsy
    end
  end
end
