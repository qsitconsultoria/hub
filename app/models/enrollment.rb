class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  accepts_nested_attributes_for :student

  enum status: {
    waiting:  0,
    approved: 1,
    rejected: 2
  }

  def approve!
    approved!
  end

  def reject!
    rejected!
  end
end
