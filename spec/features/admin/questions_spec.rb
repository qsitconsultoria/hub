require 'spec_helper'

feature "Questions" do
  scenario 'create, update and delete a question' do
    make_dependencies!

    sign_in_user(@teacher)

    visit admin_unit_course_subject_topics_url(@unit, @course, @subject)

    click_link 'Adicionar Questão do Módulo'

    fill_in 'question[title]', with: 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?'

    click_button 'Salvar'

    expect(page).to have_content 'Questão: How much wood would a woodchuck chuck if a woodchuck could chuck wood?'

    click_link 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?'

    fill_in 'question[title]', with: 'Can you can a can as a canner can can a can?'

    click_button 'Salvar'

    expect(page).to have_content 'Questão: Can you can a can as a canner can can a can?'
    expect(page).not_to have_content 'Questão: How much wood would a woodchuck chuck if a woodchuck could chuck wood?'

    click_link 'Can you can a can as a canner can can a can?'

    click_link 'Excluir'

    expect(page).to have_content 'Adicionar Questão do Módulo'
  end

  def make_dependencies!
    @unit = FactoryGirl.create(:unit)
    @course = FactoryGirl.create(:course, unit: @unit)
    @teacher = create_teacher
    Teaching.create! course: @course, teacher: @teacher
    @subject = Subject.create!(name: 'Scaffold', course: @course, published_at: Date.today)
  end
end
