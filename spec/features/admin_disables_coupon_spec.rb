require 'rails_helper'

feature 'Admin disables coupon' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
    expiration_date: '22/12/2033')
    coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    click_on promotion.name 
    click_on 'Desativar Cupom'

    coupon.reload
    expect(page).to have_content('Cupom ABC0001 - Desativado')
    expect(coupon).to be_disabled
    
  end
  scenario 'Does not see button' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
    expiration_date: '22/12/2033')
    disabled_coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, status: :disabled)
    enabled_coupon = Coupon.create!(code: 'ABC0002', promotion: promotion, status: :enabled)
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name

    expect(page).to have_content('Cupom ABC0001 - Desativado')
    expect(page).to have_content('Cupom ABC0002 - Ativo')

    within("div#coupon-#{enabled_coupon.id}") do
      expect(page).to have_link 'Desativar'
    end

    within("div#coupon-#{disabled_coupon.id}") do
      expect(page).not_to have_link 'Desativar'
    end
  end
end