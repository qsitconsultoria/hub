class StudentMailer < ActionMailer::Base
  default subject: 'GIZ Hub: Resposta de aluno'
  default from: 'quero@startae.com.br'

  def answer(answer, student, teacher, context)
    @answer = answer
    @question = answer.question
    @subject = answer.subject
    @student = student
    @teacher = teacher
    @context = context

    mail to: email_from(teacher), from: email_from(student)
  end

  def successfully_enrolled(student, course)
    @student = student
    @course = course

    mail to: "#{@student.name} <#{@student.email}>", subject: "GIZ Hub: Você está aguardando aprovação de matrícula no curso #{@course.name}"
  end

  def enrollment_approved(student, course)
    @student = student
    @course = course

    mail to: "#{@student.name} <#{@student.email}>", subject: "GIZ Hub: Sua matrícula no curso #{@course.name} foi aprovada!"
  end

  def enrollment_rejected(student, course)
    @student = student
    @course = course

    mail to: "#{@student.name} <#{@student.email}>", subject: "GIZ Hub: Sua matrícula no curso #{@course.name} não foi aprovada!"
  end

  private
    def email_from(user)
      "#{user.name} <#{user.email}>"
    end
end
