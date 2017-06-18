require "spec_helper"

describe StudentMailer, skip: true do
  let(:student) { FactoryGirl.create :student }
  let(:teacher) { create :teacher }
  let(:question) { create :question }
  let(:answer) { create :answer, question: question }

  # TODO: deal with other contexts besides :create
  describe "answer" do
    let(:mail) { StudentMailer.answer(answer, student, teacher, :create) }

    it "renders the headers" do
      expect(mail.subject).to eq("GIZ Hub: Resposta de aluno")
      expect(mail.to).to eq([teacher.email])
      expect(mail.from).to eq([student.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Para conversar com #{student.name} responda esse email")
    end
  end
end
