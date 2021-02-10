require 'rails_helper'

feature 'Admin registers a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'from index page' do
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Registrar uma categoria',
                              href: new_category_path)
  end

  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma categoria'

    fill_in 'Nome', with: 'Vestuário Feminino'
    fill_in 'Código', with: 'VEST01'
    click_on 'Salvar'

    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_content('Vestuário Feminino')
    expect(page).to have_content('VEST01')
    expect(page).to have_link('Voltar')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(email: 'julia@dev.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Salvar'

    expect(Category.count).to eq 0
    expect(page).to have_content('Não foi possível criar a categoria')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    Category.create!(name: 'Decoração', code: 'DECOR01')

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: 'Casa'
    fill_in 'Código', with: 'DECOR01'
    click_on 'Salvar'

    expect(page).to have_content('Código já está em uso')
  end
end