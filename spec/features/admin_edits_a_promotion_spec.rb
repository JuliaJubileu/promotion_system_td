require 'rails_helper'

xfeature 'Admin edits a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'from index page' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'julia@treinadev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Editar Promoção')
  end

  scenario 'successfully' do
    user = User.create!(email: 'julia@treinadev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar Promoção'

    fill_in 'Nome', with: 'Ano Novo'
    fill_in 'Descrição', with: 'Promoção de Ano Novo'
    fill_in 'Código', with: 'VIRADA22'
    fill_in 'Data de término', with: '02/02/2022'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Promoção editada com sucesso')
    expect(page).to have_content('Ano Novo')
    expect(page).to have_content('Promoção de Ano Novo')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('VIRADA22')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('100')
  end
end