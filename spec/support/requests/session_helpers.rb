module Requests
  module SessionHelpers
    include Devise::TestHelpers
    def sign_in_student
      @request.env["devise.mapping"] = Devise.mappings[:student]
      @current_student = Student.find_or_create_by(email: 'student@example.com') do |student|
        student.name = 'Student'
        student.password = '123123123'
        student.works_on = 'Servidor Público Federal'
        student.scholarity_level = 'Mestrado'
        student.field_of_operation = 'Direito'
      end
      sign_in @current_student
      @current_student
    end

    def current_student
      @current_student
    end

    def sign_in_teacher
      @request.env["devise.mapping"] = Devise.mappings[:teacher]
      @current_teacher = Teacher.find_or_create_by(email: 'teacher@example.com') do |teacher|
        teacher.name = 'Teacher'
        teacher.password = '123123123'
      end
      sign_in @current_teacher
      @current_teacher
    end

    def current_teacher
      @current_teacher
    end
  end
end
