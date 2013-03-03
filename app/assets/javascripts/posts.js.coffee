# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  window.Post = Backbone.Model.extend
    url: "/posts"
    defaults:
      title: "new post"
      content: "this is a post"
      comment: ""

    validate: (attrs) ->
      return "title cannot be empty" if $.trim(attrs.title) ==""
