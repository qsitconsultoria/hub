require 'spec_helper'

feature "Teachers" do
  scenario 'create, update and destroy a Teacher' do
    make_dependencies!

    sign_in_user(@teacher)

    visit admin_unit_course_teachers_path(@unit, @course)

    click_link 'Adicionar Tutor'

    fill_in 'teacher[name]', with: 'Jony Ive'
    fill_in 'teacher[email]', with: 'jony@apple.com'
    fill_in 'teacher[password]', with: '123123123'
    fill_in 'teacher[password_confirmation]', with: '123123123'

    click_button 'Salvar'

    expect(page).to have_content 'Jony Ive'

    click_link 'Jony Ive'

    expect(page).to have_content 'Informações Básicas'

    fill_in 'teacher[name]', with: 'Steve Jobs'

    click_button 'Salvar'

    expect(page).not_to have_content 'Jony Ive'

    expect(page).to have_content 'Steve Jobs'

    click_link 'Steve Jobs'

    click_link 'Excluir'

    expect(page).not_to have_content 'Steve Jobs'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
  end
end
