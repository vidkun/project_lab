# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
nextweek = ->
  today = new Date()
  nextweek = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 7)
  nextweek
$ ->
  $("#datetimepicker1").datetimepicker
    defaultDate: nextweek()
    pickDate: true
    pickTime: true
    minuteStepping: 15
    minDate: moment()

  return
