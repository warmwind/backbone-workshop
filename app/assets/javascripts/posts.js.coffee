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

    initialize: ->
      this.set("timestamp", new Date().getTime())

    validate: (attrs) ->
      return "title cannot be empty" if $.trim(attrs.title) ==""

    window.NewPostView = Backbone.View.extend
      events:
        "click .delete": "delete"
        "click .save_one": "saveOne"
        "change  .field": "update"
      template: _.template """
<div class="new_post" id='post_<%= timestamp%>'>
  <span class='error'></span>
  <div class='field'>
    <label for='title_<%= timestamp%>'>title</label><br />
    <input id='title_<%= timestamp%>' type='text' data-field='title' value='<%= title %>'/>
  </div>
  <div class='field'>
    <label for='content_<%= timestamp%>'>content</label><br />
    <textarea  id="content_<%= timestamp%>" cols="30" rows="10" data-field='content'><%= content %></textarea>
  </div>
  <div class='field'>
    <label for='comment_<%= timestamp%>'>comment</label><br />
    <textarea id="comment_<%= timestamp%>" cols="30" rows="10" data-field='comment'><%= comment %></textarea>
  </div>
  <button class='save_one' data-post='post_<%= timestamp%>'>Save</button>
  <a href="javascript:void(0)" class="delete">Delete</a>
</div>
                         """
      render: ->
        this.$el.append this.template this.model.attributes
        return this
      delete: (e)->
        $(e.target).parent().remove()
      update: (e)->
        if($(e.target).parents(".new_post").attr('id') == "post_#{this.model.get('timestamp')}")
          target = $(e.target)
          attribute = target.data("field")
          attrs = {}
          attrs[attribute] = target.val()
          this.model.set attrs

      saveOne: (e)->
        if($(e.target).data('post') == "post_#{this.model.get('timestamp')}")
          res = this.model.save {},
            success: (model, response, options) ->
              $(e.target).parent().remove()
            error: (model, xhr, options) ->
              $("#post_#{this.model.get('timestamp')} .error").html xhr.responseText
          unless res
            $("#post_#{this.model.get('timestamp')} .error").html this.model.validationError

  $("#add_one").on 'click', ->
    post = new Post()
    new NewPostView({model: post, el: "#new_area"}).render()
