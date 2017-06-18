require 'spec_helper'

feature 'Users' do
  scenario 'can see public profiles' do
    make_dependencies!

    sign_in_user(@student)

    within '.forum-preview' do
      click_link 'Scaffold'
    end

    click_link 'Teacher'

    expect(page).to have_content 'Teacher'
    expect(page).to have_content 'Unidade:'
    expect(page).to have_content 'Tipo de usuário: Professor'

    visit user_url(@student)

    expect(page).to have_content 'Student'
    expect(page).to have_content 'Unidade:'
    expect(page).to have_content 'Tipo de usuário: Estudante'
  end

  def make_dependencies!
    @student = create_student
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @forum = @course.forum

    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
    @forum_thread = ForumThread.create!(title: @subject.name, user: @teacher, forum: @forum, position: 1)
  end
end
