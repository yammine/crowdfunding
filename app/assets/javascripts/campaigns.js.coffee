# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".add_fields").click ->
    time  = new Date().getTime()
    regex = new RegExp($(@).data("id"), "g")
    $(@).before($(@).data("fields").replace(regex, time)) 
    false
  $(document).on "click", ".remove-field", ->
    $(@).parents("fieldset").find("input[type=hidden]").val("1")
    $(@).parents("fieldset").fadeOut()
    false
