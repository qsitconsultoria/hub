$ ->
  # Admin: New course
  $("#course_name").slugIt
    output: "#course_slug"
    map:
      "!": " "

  # Admin: New module
  $("#subject_name").slugIt
    output: "#subject_slug"
    map:
      "!": " "
