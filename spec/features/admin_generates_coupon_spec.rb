require 'rails_helper'

feature 'Admin generates coupons' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'of a promotion' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Gerar cupons'

    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to have_content('NATAL10-0001')
    expect(page).to have_content('NATAL10-0002')
    expect(page).to have_content('NATAL10-0100')
    expect(page).to_not have_content('NATAL10-0101')
  end

  scenario 'hide button if coupons generated' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

    login_as user, scope: :user
    promotion.coupons.create!
    visit promotion_path(promotion)

    expect(page).to_not have_link('Gerar cupons')
  end
end
