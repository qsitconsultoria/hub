class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :answerable, polymorphic: true

  def subject
    question.subject
  end
end
