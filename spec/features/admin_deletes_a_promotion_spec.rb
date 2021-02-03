require 'rails_helper'

feature 'Admin deletes a promotion' do
  scenario 'from index page' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Deletar Promoção')
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Deletar Promoção'

    expect(Promotion.count).to eq 0
    expect(page).to have_content('Promoção deletada com sucesso')
  end
end