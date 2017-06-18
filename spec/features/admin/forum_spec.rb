require 'spec_helper'

feature "Forum" do
  scenario 'create, update and delete an forum_thread of the forum' do
    make_dependencies!

    sign_in_user(@teacher)

    visit admin_unit_course_url(@unit, @course)

    click_link 'Fórum'

    expect(page).to have_content 'Itens do Fórum'

    click_link 'Adicionar Tópico'

    fill_in 'forum_thread[title]', with: 'Scaffold'
    fill_in 'forum_thread[content]', with: 'Praesent commodo cursus magna, vel scelerisque nisl consectetur et.'

    click_button 'Salvar'

    expect(page).to have_content 'Scaffold'

    click_link 'Scaffold'

    fill_in 'forum_thread[title]', with: 'Views'
    fill_in 'forum_thread[content]', with: 'Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.'

    click_button 'Salvar'

    expect(page).not_to have_content 'Scaffold'
    expect(page).to have_content 'Views'

    click_link 'Views'

    click_link 'Excluir'

    expect(page).to have_content 'Itens do Fórum'
    expect(page).not_to have_content 'Views'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
    @forum = Forum.create!(name: 'Rails for Designers', course: @course)
  end
end
