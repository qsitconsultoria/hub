require 'spec_helper'

feature "Subjects" do
  scenario 'create, update and delete a subject' do
    make_dependencies!

    sign_in_user(@teacher)

    visit admin_unit_course_url(@unit, @course)

    click_link 'Módulos'

    expect(page).to have_content '1 Módulo em Rails for Designers'
    expect(page).to have_content 'Scaffold'

    click_link 'Adicionar Módulo'

    fill_in 'subject[name]', with: 'Frontend do Rails'
    fill_in 'subject[description]', with: 'Você vai aprender as configurações essenciais para criar código mais limpo e explorar as views e assets implementando o visual do Bootstrap no admin do projeto.'
    fill_in 'subject[video]', with: 'http://youtu.be/UF8uR6Z6KLc'

    click_button 'Salvar'

    expect(page).to have_content 'Frontend do Rails'

    within '.nav-top' do
      click_link 'Módulos'
    end

    expect(page).to have_content '2 Módulos em Rails for Designers'

    visit admin_unit_course_subject_topics_url(@unit, @course, @subject)

    expect(page).to have_content 'Módulo 01'
    expect(page).to have_content 'Scaffold'

    click_link 'Editar Módulo'

    fill_in 'subject[name]', with: 'Primeiros passos no Rails'
    fill_in 'subject[description]', with: 'Aprenda a criar um projeto'
    fill_in 'subject[video]', with: 'http://youtu.be/dQw4w9WgXcQ'

    click_button 'Salvar'

    expect(page).to have_content 'Primeiros passos no Rails'

    within '.nav-top' do
      click_link 'Módulos'
    end

    expect(page).to have_content '2 Módulos em Rails for Designers'

    expect(page).to have_content 'Primeiros passos no Rails'
    expect(page).not_to have_content 'Scaffold'

    visit admin_unit_course_subject_topics_url(@unit, @course, Subject.last)

    expect(page).to have_content 'Módulo 02'
    expect(page).to have_content 'Frontend do Rails'

    click_link 'Editar Módulo'

    click_link 'Excluir'

    expect(page).to have_content '1 Módulo em Rails for Designers'
    expect(page).to have_content 'Primeiros passos no Rails'
    expect(page).not_to have_content 'Frontend do Rails'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @teacher = create_teacher
    @teacher.unit = @unit
    @teacher.save!
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
  end
end
