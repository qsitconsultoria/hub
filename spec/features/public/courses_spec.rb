# encoding: utf-8
require 'spec_helper'

feature "Courses" do
  scenario 'student can navigate on every page of the course' do
    make_dependencies!

    sign_in_user(@student)

    expect(page).to have_content 'Rails for Designers'

    expect(page).to have_content 'Módulos nesse curso (1)'

    within '.list--modules' do
      within '.list__item' do
        expect(page).to have_content '01'
        expect(page).to have_content 'Intro'

        click_button 'Estudar'
      end
    end
  end

  def make_dependencies!
    @student = create_student
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @intro = Subject.create!(name: 'Intro', course: @course, published_at: Date.today)
    @views = Topic.create!(name: 'Views', subject: @intro)
  end
end
