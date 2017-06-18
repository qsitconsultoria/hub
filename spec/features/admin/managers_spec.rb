require 'spec_helper'

feature 'Managers' do
  scenario 'choose a manager from select after filling the fields for a new should clear the fields' do
    make_dependencies!

    sign_in_user(@admin)

    click_link 'Test Unit 2'

    click_link 'Gestores'

    click_link 'Adicionar Gestor'

    fill_in 'manager[name]', with: 'João'
    fill_in 'manager[email]', with: 'joao@silva.com'

    select 'Manager', from: 'manager[id]'

    #TODO: update this scenario using js: true

    # expect(page).not_to have_content 'João'
    # expect(page).not_to have_content 'joao@silva.com'

    # click_button 'Salvar'
  end

  def make_dependencies!
    @admin = create_admin_user
    @manager = create_manager
    @unit = FactoryGirl.create(:unit, managers: [@manager])
    @unit_2 = FactoryGirl.create(:unit, name: 'Test Unit 2')
  end
end
