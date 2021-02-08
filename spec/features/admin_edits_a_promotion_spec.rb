require 'rails_helper'

feature 'Admin edits a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'from index page' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user
    
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Editar Promoção')
  end

  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
    expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar Promoção'

    fill_in 'Nome', with: 'Ano Novo'
    fill_in 'Descrição', with: 'Promoção de Ano Novo'
    fill_in 'Código', with: 'VIRADA22'
    fill_in 'Data de término', with: '02/02/2022'
    click_on 'Salvar'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Ano Novo')
    expect(page).to have_content('Promoção de Ano Novo')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('VIRADA22')
    expect(page).to have_content('02/02/2022')
    expect(page).to have_content('100')
  end
  scenario 'and attributes can not be blank' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
    expiration_date: '22/12/2033', user: user)
    
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar Promoção'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Salvar'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Não foi possível editar a promoção')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Data de término não pode ficar em branco')
  end
end