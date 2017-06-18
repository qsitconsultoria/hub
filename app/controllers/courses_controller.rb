class CoursesController < ApplicationController
  def show
    @course = @unit.courses.friendly.find(params[:id])
    @subjects = @course.subjects.ordered
    @links = @course.links.limit(5)
    @forum = @course.forum
  end

  def redirect_to_course
    unit = Unit.find_by(name: 'Unidade Virtual ICMBIO/Teste')
    course = Course.friendly.find(params[:id])

    redirect_to unit_course_url(unit, course)
  end
end
