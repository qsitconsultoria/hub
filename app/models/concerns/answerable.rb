module Answerable
  extend ActiveSupport::Concern

  included do
    has_many :answers, as: :answerable, dependent: :destroy
  end

  def answered?(question)
    answers.includes(:question).where(question: question).any?
  end

  def answer_for(question)
    answers.includes(:question).where(question: question).first
  end
end