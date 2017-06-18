module ApplicationHelper
  def library_section?
    params[:controller] == 'library_files'
  end

  def button_to(*args, &block)
    link_to(*args, class: 'btn btn--primary', &block)
  end

  def nav_status_class(string, controller, action=nil)
    if action.nil?
      if params[:controller] =~ Regexp.new(controller)
        string + ' is-active'
      else
        string
      end
    else
      string + ' is-active' if "#{params[:controller]}/#{params[:action]}" == "#{controller}/#{action}"
    end
  end

  def units_for_select
    current_user.units.collect {|u| [ u.name, admin_unit_path(u) ] }
  end

  def courses_for_select
    options = @courses.collect {|c| [ c.name, admin_unit_course_dashboard_index_path(current_unit, c) ] }
    options.unshift ['Escolha um Curso', nil] unless current_course
    options << ['', nil]
    options << ['+ Criar Curso', new_admin_unit_course_path(current_unit)]
    options
  end

  def current_course
    @course if @course.present? and @course.persisted?
  end

  def current_unit
    @unit if @unit.present? and @unit.persisted?
  end

  def custom_class_for flash_type
    { success: "alert--success", error: "alert--error", alert: "alert--warning", notice: "alert--info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{custom_class_for(msg_type)} fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def link_to_if_with_block(condition, options, html_options={}, &block)
    if condition
      link_to options, html_options, &block
    else
      capture &block
    end
  end

  def landing
    @landing || false
  end

  def color_theme(unit)
    unit.color_theme || "theme--dark"
  end

  def admin_library_controllers
    ['admin/library_files', 'admin/library/themes', 'admin/library/territorial_coverages', 'admin/library/biomes', 'admin/library/courses', 'admin/library/filetypes', 'admin/library/languages', 'admin/library/years']
  end

  def count_elements(attribute, value)
    LibraryFile.pluck(attribute.to_sym).count(value)
  end

  def readable_file_size(size, precision)
    case
      when size == 1; "1 Byte"
      when size < 1024.0; "%d Bytes" % size
      when size < 1048576.0; "%.#{precision}f KB" % (size / 1024.0)
      when size < 1073741824.0; "%.#{precision}f MB" % (size / 1048576.0)
      else "%.#{precision}f GB" % (size / 1073741824.0)
    end
  end

  def truncate_filename(string)
    if string.length > 20
      string[0, 20] + '...' + string[-10, 10]
    else
      string
    end
  end
end
