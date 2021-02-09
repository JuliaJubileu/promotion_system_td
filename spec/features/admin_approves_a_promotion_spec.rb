feature 'Admin approves a promotion' do
    scenario 'must be signed in' do
      visit root_path
      click_on 'Promoções'
    
      expect(current_path).to eq new_user_session_path
    end
    scenario 'must not be the creator' do
        creator = User.create!(email: 'julia@dev.com', password: '123456')
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
        expiration_date: '22/12/2033', user: creator)
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)
        approver = User.create!(email: 'joao@dev.com', password: 'fAk3pA55w0rD')

        login_as creator, scope: :user
        visit promotion_path

        expect(page).not_to have_link('Aprovar Promoção')
    end
    scenario 'must be another user' do 
        creator = User.create!(email: 'julia@dev.com', password: '123456')
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
        expiration_date: '22/12/2033', user: creator)
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)
        approver = User.create!(email: 'joao@dev.com', password: 'fAk3pA55w0rD')

        login_as approver, scope: :user
        visit promotion_path

        expect(page).to have_link 'Aprovar Promoção'
    end
end