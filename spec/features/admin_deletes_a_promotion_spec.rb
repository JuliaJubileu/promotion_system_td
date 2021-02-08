require 'rails_helper'

feature 'Admin deletes a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'from index page' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Deletar Promoção')
  end

  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    first_promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
    expiration_date: '22/12/2033', user: user)
    second_promotion = Promotion.create!(name: 'Ano Novo', description: 'Promoção de Ano Novo',
    code: 'NOVO22', discount_rate: 5, coupon_quantity: 40,
    expiration_date: '02/01/2022', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Deletar Promoção'

    expect(Promotion.count).to eq 1
    expect(page).to have_content('Ano Novo')
    expect(page).to have_content('Promoção de Ano Novo')
    expect(page).to have_content('NOVO22')

    expect(page).not_to have_content('Natal')
    expect(page).not_to have_content('Promoção de Natal')
    expect(page).not_to have_content('NATAL10')
  end
end