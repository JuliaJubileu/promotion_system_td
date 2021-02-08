require 'rails_helper'

xfeature 'Admin deletes a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'from index page' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Deletar Promoção')
  end

  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Deletar Promoção'

    expect(Promotion.count).to eq 0
    expect(page).to have_content('Promoção deletada com sucesso')
  end
end