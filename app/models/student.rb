class Student < User
  # include UserProfiled
  has_many :enrollments
  has_many :courses, through: :enrollments

  validates :works_on, :scholarity_level, :field_of_operation, presence: true

  def enrolled_in?(course)
    enrollments.map(&:course).include? course
  end

  def enrollment_status_on(course)
    if enrolled_in? course
      enrollments.find_by(course: course).status
    else
      raise "Não está matriculado"
    end
  end
end
