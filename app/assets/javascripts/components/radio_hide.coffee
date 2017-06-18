$(document).ready ->
  $("input[name=work]").change ->
    if $(this).is(":checked") and $(this).val() is "sim"
      $("#student_works_on").empty()
      $("#student_works_on").append new Option("Federal", "Servidor Público Federal")
      $("#student_works_on").append new Option("Estadual", "Servidor Público Estadual")
      $("#student_works_on").append new Option("Municipal", "Servidor Público Municipal")
    else
      if $(this).is(":checked") and $(this).val() is "nao"
        $("#student_works_on").empty()
        $("#student_works_on").append new Option("Agricultura", "Agricultura")
        $("#student_works_on").append new Option("Comércio", "Agricultura")
        $("#student_works_on").append new Option("Indústria", "Indústria")
        $("#student_works_on").append new Option("Serviços", "Serviços")
        $("#student_works_on").append new Option("ONG", "ONG")
    return
