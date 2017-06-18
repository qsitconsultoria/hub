require 'spec_helper'

feature "Forum" do
  scenario 'create and delete a Post' do
    make_dependencies!

    sign_in_user(@student)

    expect(page).to have_content 'Itens no fórum (1)'

    within '.forum-preview' do
      click_link 'Scaffold'
    end

    fill_in 'forum_post[content]', with: 'Este post esclarece minha dúvida, professor!'
    click_button 'Publicar'

    expect(page).to have_content '1 Resposta'
    expect(page).to have_content 'Este post esclarece minha dúvida, professor!'

    click_link 'Excluir'

    expect(page).to have_content '0 Respostas'
    expect(page).not_to have_content 'Este post esclarece minha dúvida, professor!'
  end

  scenario 'create and delete a Reply' do
    make_dependencies!

    ForumPost.create!(content: 'Estudem os links deste post, pessoal!', forum_thread: @forum_thread, user: @teacher)

    sign_in_user(@student)

    expect(page).to have_content 'Itens no fórum (1)'

    within '.forum-preview' do
      click_link 'Scaffold'
    end

    expect(page).to have_content '1 Resposta'
    expect(page).to have_content 'Estudem os links deste post, pessoal!'

    click_link 'Responder'

    fill_in 'reply[content]', with: 'Ok, professor!'

    within '.forum-answers-list__reply-form' do
      click_button 'Publicar'
    end

    expect(page).to have_content 'Ok, professor!'

    click_link 'Excluir'

    expect(page).to have_content 'Estudem os links deste post, pessoal!'
    expect(page).not_to have_content 'Ok, professor!'
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
