require 'rails_helper'

xfeature 'Admin edits a promotion' do
  scenario 'from index page' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Editar Promoção')
  end

  scenario 'successfully' do
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