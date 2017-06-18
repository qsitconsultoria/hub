require 'spec_helper'

feature "Courses" do
  scenario 'create, update and destroy a Course' do
    make_dependencies!

    sign_in_user(@manager)

    visit new_admin_unit_course_path(@unit)

    fill_in 'course[name]', with: 'Frontend Responsa!'
    fill_in 'course[subname]', with: 'Da telinha para a telona. Implemente sites que se adaptam a todos os tamanhos de tela.'

    click_button 'Salvar'

    visit admin_unit_path(@unit)

    expect(page).to have_content 'Frontend Responsa!'

    visit edit_admin_unit_course_url(@unit, Course.last)

    expect(page).to have_field 'course[name]', with: 'Frontend Responsa!'

    fill_in 'course[name]', with: 'iPhone App: do Design à Implementação'
    fill_in 'course[subname]', with: 'Crie uma app para iPhone do zero botando a mão na massa desde o design até a programação. Mãos à obra!'

    click_button 'Salvar'

    visit admin_unit_path(@unit)

    expect(page).not_to have_content 'Frontend Responsa!'
    expect(page).to have_content 'iPhone App: do Design à Implementação'

    visit edit_admin_unit_course_url(@unit, Course.last)

    click_link 'Excluir'
  end

  scenario 'duplicate a Course with all its content' do
    make_dependencies!
    unit_2 = FactoryGirl.create(:unit, name: 'Test Unit 2')

    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    scaffold = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
    topic = Topic.create!(name: 'Views', subject: scaffold)
    question = Question.create!(title: 'How much wood could a woodchuck chuck if a woodchuck could chuck wood?', subject: scaffold)

    sign_in_user(@manager)

    visit admin_unit_url(@unit)

    click_link 'Editar'
    click_link 'Módulos'

    expect(page).to have_content 'Scaffold'

    within '.sidebar' do
      click_link 'Configurações'
    end

    expect(page).not_to have_content 'Duplicar curso em...'

    unit_2.managers << @manager

    within '.sidebar' do
      click_link 'Configurações'
    end

    expect(page).to have_content 'Duplicar curso em...'

    click_link 'Duplicar curso em...'

    expect(page).to have_content 'Escolha a unidade em que deseja duplicar o curso Rails for Designers'
    select 'Test Unit 2', from: 'course[unit_id]'

    click_button 'Salvar'

    expect(page).to have_content 'Test Unit 2'
    expect(page).to have_content 'Scaffold'

    click_link 'Scaffold'

    expect(page).to have_content question.title
    expect(page).to have_content topic.name
  end

  def make_dependencies!
    @manager = create_manager
    @unit = FactoryGirl.create(:unit, managers: [@manager])
    @course = FactoryGirl.create(:course, unit: @unit)
  end
end
