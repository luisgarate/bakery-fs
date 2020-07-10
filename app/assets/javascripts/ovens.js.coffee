# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  setInterval (->
    $('.cookie-info').load '/ovens/reload_oven #cookie-status'
    return
  ), 2000
  return
