require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'from the home page' do 
    visit root_url 

    expect(page).to have_link('Registre-se')
  end

  scenario 'with valid email and password' do
    visit root_url

    click_button 'Registre-se'
    fill_in 'E-mail', with: 'julia@dev.com'
    fill_in 'Senha', with: '123456'
    click_link 'Registrar'

    expect(page).to have_content('julia@dev.com')
  end

  scenario 'with invalid email' do
    visit root_url
    click_button 'Registre-se'
    fill_in 'E-mail', with: 'email_invalido'
    fill_in 'Senha', with: '123456'
    click_link 'Registrar'

    expect(page).to have_content('Entrar')
  end

  scenario 'with blank password' do
    visit root_url
    click_button 'Registre-se'
    fill_in 'E-mail', with: 'julia@dev.com'
    fill_in 'Senha', with: ''
    click_button 'Registrar'

    expect(page).to have_content('Registre-se')
  end
end