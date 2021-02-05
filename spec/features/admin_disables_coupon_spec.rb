require 'rails_helper'

feature 'Admin disables coupon' do
    scenario 'successfully' do
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
        expiration_date: '22/12/2033')
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

        visit root_path
        click_on 'Promoções'
        click_on promotion.name 
        click_on 'Desativar Cupom'

        expect(page).to have_content('Cupom ABC0001 inativo')
    
    end
end