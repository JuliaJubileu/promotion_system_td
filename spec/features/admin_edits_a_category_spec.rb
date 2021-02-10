require 'rails_helper'

feature 'Admin edits a category' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'from index page' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user
    
    Category.create!(name: 'Decoração', code: 'DECOR01')

    visit root_path
    click_on 'Categorias'
    click_on 'Decoração'

    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_link('Editar Categoria')
  end

  scenario 'successfully' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    Category.create!(name: 'Decoração', code: 'DECOR01')

    visit root_path
    click_on 'Categorias'
    click_on 'Decoração'
    click_on 'Editar Categoria'

    fill_in 'Nome', with: 'Brinquedos'
    fill_in 'Código', with: 'BRINCA01'
    click_on 'Salvar'

    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_content('Brinquedos')
    expect(page).to have_content('BRINCA01')
  end
  scenario 'and attributes can not be blank' do
    user = User.create!(email: 'julia@dev.com', password: '123456')
    login_as user, scope: :user

    Category.create!(name: 'Decoração', code: 'DECOR01')

    visit root_path
    click_on 'Categorias'
    click_on 'Decoração'
    click_on 'Editar Categoria'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Salvar'

    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_content('Não foi possível editar a Categoria')
    expect(page).to have_content('Código não pode ficar em branco')
  end
end