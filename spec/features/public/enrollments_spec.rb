require 'spec_helper'

feature "Enrollments" do
  scenario 'student request enrollment on a course and a manager accepts it' do
    make_dependencies!

    # Visit as unknown user
    visit root_url
    expect(page).to have_content 'Bem vindo aos cursos da Test Unit'
    expect(page).to have_content 'Rails for Designers'

    click_link 'Ver Curso'

    expect(page).to have_content 'MATRICULAR NESSE CURSO'
    expect(page).to have_content 'Já está matriculado? Faça o login'

    # Student login
    click_link 'Faça o login'

    fill_in 'user[email]', with: @student.email
    fill_in 'user[password]', with: @student.password
    click_button 'Entrar'

    expect(page).to have_content 'Rails for Designers'
    expect(page).to have_content 'MATRICULAR NESSE CURSO'
    expect(page).not_to have_content 'Já está matriculado? Faça o login'
    expect(page).not_to have_content 'Progresso'

    # Student enroll himself
    click_link 'MATRICULAR NESSE CURSO'

    expect(page).to have_content 'Pedido de matrícula realizado com sucesso!'

    click_link 'VOLTAR PARA PÁGINA DO CURSO'

    expect(page).to have_content 'MATRICULADO E AGUARDANDO APROVAÇÃO'

    click_link 'Intro'

    expect(page).to have_content 'Por enquanto você não pode acessar esta área.'

    click_link 'Sair'

    # Sign in manager
    sign_in_user(@manager)

    # Manager approve student request
    visit admin_unit_course_url(@unit, @course)
    click_link 'Painel'
    expect(page).to have_content '1 aluno está aguardando aprovação nesse curso.'
    click_link 'Ver novos alunos'
    expect(page).to have_content '1 pessoa está aguardando aprovação'
    within '#romulo' do
      click_link 'Aprovar'
    end

    click_link 'Sair'

    # Sign in as student
    visit root_url
    click_link 'Ver Curso'

    click_link 'Faça o login'
    fill_in 'user[email]', with: @student.email
    fill_in 'user[password]', with: @student.password
    click_button 'Entrar'

    # Show progress bar meaning student is enrolled
    expect(page).to have_content 'Progresso'
  end

  def make_dependencies!
    @manager = create_manager
    @unit = FactoryGirl.create(:unit, managers: [@manager])
    @course = FactoryGirl.create(:course, unit: @unit)
    @intro = Subject.create!(name: 'Intro', course: @course, published_at: Date.today)
    @views = Topic.create!(name: 'Views', subject: @intro)

    @student = FactoryGirl.create(:student, name: 'Rômulo', email: 'romulo@startae.com.br',
                                            works_on: 'ONG', scholarity_level: 'Mestrado',
                                            field_of_operation: 'Direito')
  end
end
