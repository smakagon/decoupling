require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
  let!(:user) { create(:user) }

  context 'GET #index' do
    it 'shows existing users' do
      create(:user, first_name: 'Adrian')

      visit users_path
      expect(page).to have_content(user.first_name)
      expect(page).to have_content('Adrian')
    end
  end

  context 'user creation' do
    it 'creates user with valid params' do
      visit new_user_path

      fill_in :user_first_name, with: 'Test'
      fill_in :user_last_name, with: 'User'
      fill_in :user_password, with: 'password'
      click_on 'Create'

      expect(page.current_path).to eq(user_path(User.last))
      expect(page).to have_content('Test User')
    end

    it 'doesn\'t save user without required params' do
      visit new_user_path

      click_on 'Create'

      expect(page.current_path).to eq(users_path)
      expect(page).to have_content('First name can\'t be blank')
      expect(page).to have_content('Last name can\'t be blank')
      expect(page).to have_content('Password can\'t be blank')
    end
  end

  context 'update user' do
    it 'updates user with valid params' do
      visit edit_user_path(user)

      fill_in :user_first_name, with: 'Adrian'
      fill_in :user_last_name, with: 'Lewis'
      click_on 'Update'

      user.reload
      expect(user.first_name).to eq('Adrian')
      expect(user.last_name).to eq('Lewis')
    end

    it 'validates user params on update' do
      visit edit_user_path(user)

      fill_in :user_first_name, with: ''
      fill_in :user_last_name, with: ''
      click_on 'Update'

      expect(page).to have_content('First name can\'t be blank')
      expect(page).to have_content('Last name can\'t be blank')
    end
  end

  context 'GET #show' do
    it 'shows user\'s profile' do
      visit user_path(user)

      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
    end
  end

  context 'DELETE #destroy' do
    it 'removes user' do
      visit users_path
      click_on 'delete'

      expect(page.current_path).to eq(users_path)
      expect(User.count).to eq(0)
    end
  end
end
