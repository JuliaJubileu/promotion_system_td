require 'rails_helper'

feature 'User searches for promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    first_promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                               code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                               expiration_date: '22/12/2033', user: user)
    second_promotion = Promotion.create!(name: 'Aniversário', description: 'Promoção de aniversário',
                               code: 'NIVER50', discount_rate: 50, coupon_quantity: 50,
                               expiration_date: '25/12/2022', user: user)

    login_as user, scope: :user
    visit root_path
    fill_in 'Busca:', with: 'Natal'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Natal')
    expect(page).to have_content('NATAL10')
    expect(page).not_to have_content('Aniversário')
    expect(page).not_to have_content('Promoção de Ano Novo')
  end
  scenario 'and sees error message when search fails' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    first_promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                               code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                               expiration_date: '22/12/2033', user: user)
    second_promotion = Promotion.create!(name: 'Aniversário', description: 'Promoção de aniversário',
                               code: 'NIVER50', discount_rate: 50, coupon_quantity: 50,
                               expiration_date: '25/12/2022', user: user)

    login_as user, scope: :user
    visit root_path
    fill_in 'Busca:', with: 'Ano Novo'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Nenhuma promoção encontrada')
    expect(page).to have_link('Voltar')
  end
end