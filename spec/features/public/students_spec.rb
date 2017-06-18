require 'spec_helper'

feature "Students" do
  scenario 'student can sign up', skip: true do
    make_dependencies!

    visit root_url

    expect(page).to have_content 'Bem vindo aos cursos da Test Unit'
    expect(page).to have_content 'Rails for Designers'

    click_link 'Ver Curso'

    click_link 'MATRICULAR NESSE CURSO'

    # TODO: upload avatar
    fill_in 'enrollment[student][name]', with: 'Aluno'
    fill_in 'enrollment[student][email]', with: 'aluno@email.com'
    fill_in 'enrollment[student][password]', with: '123123123'
    fill_in 'enrollment[student][password_confirmation]', with: '123123123'
    # TODO: choose radio button (depends on JS)
    select 'Mestrado', from: 'enrollment[student][scholarity_level]'
    select 'Economia', from: 'enrollment[student][field_of_operation]'

    click_button 'Cadastrar'

    expect(page).to have_content 'Pedido de matrícula realizado com sucesso!'
    expect(page).to have_content 'Aluno'
    expect(page).to have_content 'Sair'
  end

  scenario 'student can edit his profile' do
    make_dependencies!

    @student = create_student

    sign_in_user(@student)

    click_link 'Student'

    expect(page).to have_content 'Editar perfil'
    # TODO: use js on this scenario
    # choose 'Sim'
    # select 'Federal', from: 'student[works_on]'
    select 'Mestrado', from: 'student[scholarity_level]'
    select 'Direito', from: 'student[field_of_operation]'

    click_button 'Salvar'

    expect(page).to have_field 'student[scholarity_level]', with: 'Mestrado'
    expect(page).to have_field 'student[field_of_operation]', with: 'Direito'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @intro = Subject.create!(name: 'Intro', course: @course, published_at: Date.today)
    @views = Topic.create!(name: 'Views', subject: @intro)
  end
end
