require 'spec_helper'

feature "Permissions" do
  scenario 'admin user should see permission denied page' do
    make_dependencies!

    @admin = create_admin_user
    sign_in_user(@admin)

    visit admin_unit_url(@unit)

    expect(page).to have_content 'Administradores não podem acessar esta área'
  end

  scenario 'manager should see permission denied page' do
    make_dependencies!

    @manager = create_manager
    @unit.managers << @manager

    sign_in_user(@manager)

    visit admin_units_url

    expect(page).to have_content 'Gestores não podem acessar esta área'
  end

  scenario 'teacher should see permission denied page' do
    make_dependencies!

    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)

    sign_in_user(@teacher)

    visit admin_units_url

    expect(page).to have_content 'Professores não podem acessar esta área'
  end

  scenario 'student should see permission denied page' do
    make_dependencies!

    @student = create_student
    sign_in_user(@student)

    visit admin_units_url

    expect(page).to have_content 'Estudantes não podem acessar esta área'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
  end
end
