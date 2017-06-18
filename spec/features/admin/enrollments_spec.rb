require 'spec_helper'

feature "Enrollments" do
  scenario 'approve and reject students from their profile page' do
    make_dependencies!

    sign_in_user(@manager)

    visit admin_unit_course_url(@unit, @course)

    expect(page).to have_content 'Painel'
    expect(page).to have_content 'Alunos'

    click_link 'Painel'

    expect(page).to have_content '3 alunos estão aguardando aprovação nesse curso.'

    click_link 'Ver novos alunos'

    expect(page).to have_content '3 pessoas estão aguardando aprovação'
    expect(page).to have_content '0 alunos ignorados'

    click_link 'Rômulo'

    click_link 'Aprovar'

    expect(page).to have_content '2 pessoas estão aguardando aprovação'
    expect(page).to have_content '1 pessoa está fazendo este curso'

    click_link 'Renato'

    click_link 'Ignorar'

    expect(page).to have_content '1 pessoa está aguardando aprovação'
    expect(page).to have_content '1 aluno ignorado'

    click_link '1 aluno ignorado'

    expect(page).to have_content 'Renato'

    click_link 'Voltar'

    expect(page).to have_content 'Mezzomo'
    expect(page).to have_content 'Rômulo'
    expect(page).not_to have_content 'Renato'
  end

  scenario 'approve and reject students directly from the students index' do
    make_dependencies!

    sign_in_user(@manager)

    visit admin_unit_course_url(@unit, @course)

    expect(page).to have_content 'Painel'
    expect(page).to have_content 'Alunos'

    click_link 'Painel'

    expect(page).to have_content '3 alunos estão aguardando aprovação nesse curso.'

    click_link 'Ver novos alunos'

    expect(page).to have_content '3 pessoas estão aguardando aprovação'
    expect(page).to have_content '0 alunos ignorados'

    within '#romulo' do
      click_link 'Aprovar'
    end

    expect(page).to have_content '2 pessoas estão aguardando aprovação'
    expect(page).to have_content '1 pessoa está fazendo este curso'

    within '#renato' do
      click_link 'Ignorar'
    end

    expect(page).to have_content '1 pessoa está aguardando aprovação'
    expect(page).to have_content '1 aluno ignorado'

    click_link '1 aluno ignorado'

    expect(page).to have_content 'Renato'

    click_link 'Voltar'

    expect(page).to have_content 'Mezzomo'
    expect(page).to have_content 'Rômulo'
    expect(page).not_to have_content 'Renato'
  end

  def make_dependencies!
    @manager = create_manager
    @unit = FactoryGirl.create(:unit, managers: [@manager])
    @course = FactoryGirl.create(:course, unit: @unit)

    @student_1 = FactoryGirl.create(:student, name: 'Rômulo', email: 'romulo@startae.com.br',
                                              works_on: 'ONG', scholarity_level: 'Mestrado',
                                              field_of_operation: 'Direito')
    @student_2 = FactoryGirl.create(:student, name: 'Renato', email: 'renato@startae.com.br',
                                              works_on: 'ONG', scholarity_level: 'Mestrado',
                                              field_of_operation: 'Direito')
    @student_3 = FactoryGirl.create(:student, name: 'Mezzomo', email: 'mezzomo@startae.com.br',
                                              works_on: 'ONG', scholarity_level: 'Mestrado',
                                              field_of_operation: 'Direito')

    Enrollment.create! course: @course, student: @student_1
    Enrollment.create! course: @course, student: @student_2
    Enrollment.create! course: @course, student: @student_3
  end
end
