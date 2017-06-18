require 'spec_helper'

feature "Units" do
  scenario 'edit and destroy an Unit' do
    make_dependencies!

    sign_in_user(@manager)

    click_link 'Configurações'

    expect(find_field('unit_name').value).to eq @unit.name
    expect(find_field('unit_about').value).to eq @unit.about

    fill_in 'unit[name]', with: 'IBAMA'
    choose 'dark'
    fill_in 'unit[about]', with: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'

    click_button 'Salvar'

    expect(page).to have_content 'IBAMA'

    click_link 'Configurações'

    expect(page).to have_field 'unit[name]', with: 'IBAMA'
    expect(page).to have_field 'unit[about]', with: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'

    fill_in 'unit[name]', with: 'Instituto Chico Mendes'
    fill_in 'unit[slug]', with: 'instituto-chico-mendes'
    fill_in 'unit[about]', with: 'Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis.'

    click_button 'Salvar'

    expect(page).not_to have_content 'IBAMA'
    expect(page).to have_content 'Instituto Chico Mendes'

    click_link 'Configurações'

    expect(page).to have_field 'unit[name]', with: 'Instituto Chico Mendes'

    click_link 'Sair'

    @admin = create_admin_user

    sign_in_user(@admin)

    expect(page).to have_content 'Instituto Chico Mendes'
    click_link 'instituto-chico-mendes'

    click_link 'Excluir'

    expect(page).not_to have_content 'Instituto Chico Mendes'
  end

  def make_dependencies!
    @manager = create_manager
    @unit = FactoryGirl.create(:unit, managers: [@manager])
    @course = FactoryGirl.create(:course, unit: @unit)
  end
end
