# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->

  # When the user leaves the URL field check to see if the image is valid client-side.
  $(document).on 'focusout', '#reaction_url', ->
    img_url = $('#reaction_url').val()
    img = $('<img />', {src : img_url});
    $('#img_preview').empty()
    img.appendTo('#img_preview')
    
