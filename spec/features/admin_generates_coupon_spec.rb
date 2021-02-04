require 'rails_helper'

feature 'Admin generates a coupon' do
    scenario 'Of a promotion' do
        Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
        expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Natal'
        click_on 'Gerar Cupons'

        expect(page).to have_content('Cupons gerados com sucesso!')
        expect(page).to have_content('NATAL10-0001')
        expect(page).to have_content('NATAL10-0100')
        expect(page).not_to have_content('NATAL10-0101')
        expect(page).not_to have_content('NATAL10-0000')
    end
end