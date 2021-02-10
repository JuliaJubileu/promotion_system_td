require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'from the home page' do 
    visit root_url 

    expect(page).to have_link('Registre-se')
  end

  scenario 'with valid email and password' do
    visit root_url

    click_on 'Registre-se'
    fill_in 'E-mail', with: 'julia@dev.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('julia@dev.com')
  end

  scenario 'with invalid email' do
    visit root_url
    click_on 'Registre-se'
    fill_in 'E-mail', with: 'email_invalido'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('Não foi possível salvar usuário')
  end

  scenario 'with blank password' do
    visit root_url
    click_on 'Registre-se'
    fill_in 'E-mail', with: 'julia@dev.com'
    fill_in 'Senha', with: ''
    fill_in 'Confirmação da senha', with: ''
    click_on 'Registrar'

    expect(page).to have_content('Não foi possível salvar usuário')
  end
end