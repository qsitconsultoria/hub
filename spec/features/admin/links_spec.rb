require 'spec_helper'

feature "Questions" do
  scenario 'create, update and delete a question' do
    make_dependencies!

    sign_in_user(@teacher)

    visit admin_unit_course_links_url(@unit, @course)

    click_link 'Adicionar Referência'

    fill_in 'link[name]', with: 'Mussum ipsum'
    fill_in 'link[url]', with: 'http://mussumipsum.com/'
    check 'Scaffold'

    click_button 'Salvar'

    expect(page).to have_content 'Mussum ipsum'

    click_link 'Mussum ipsum'
    fill_in 'link[name]', with: 'Lorem ipsum'
    fill_in 'link[url]', with: 'http://lipsum.com/'

    click_button 'Salvar'

    expect(page).to have_content 'Lorem ipsum'
    expect(page).not_to have_content 'Mussum ipsum'

    click_link 'Lorem ipsum'
    click_link 'Excluir'

    expect(page).not_to have_content 'Lorem ipsum'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
  end
end
