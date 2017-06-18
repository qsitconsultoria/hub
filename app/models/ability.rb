class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can [:access, :access_units_index], :admin

      can [:create_unit], Unit

      can [:see_managers_link], Unit do |unit|
        !unit.new_record?
      end
    elsif user.manager?
      can [:access, :access_courses_index], :admin

      can [:edit_all_unit_fields, :see_unit_show_page], Unit

      can [:create_new_course, :edit_course, :see_course_show_page, :see_subjects, :see_links], Course

      can [:create_new_subject, :edit_subject, :see_topics, :read], Subject

      can [:create_new_topic, :edit_topic], Topic

      can [:create_new_question, :edit_question], Question

      can [:create_new_link, :edit_link], Link
    elsif user.teacher?
      can [:access, :access_courses_index], :admin

      can [:see_unit_show_page], Unit

      can [:edit_course, :see_course_show_page, :see_subjects, :see_links], Course

      can [:create_new_subject, :edit_subject, :see_topics, :read], Subject

      can [:create_new_topic, :edit_topic], Topic

      can [:create_new_question, :edit_question], Question

      can [:create_new_link, :edit_link], Link
    elsif user.student?
      can [:read], Subject do |subject|
        user.enrolled_in?(subject.course) && user.enrollment_status_on(subject.course) == 'approved'
      end
    end
  end
end
