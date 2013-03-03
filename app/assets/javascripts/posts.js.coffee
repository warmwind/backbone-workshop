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

    window.NewPostView = Backbone.View.extend
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
</div>
                         """
      render: ->
        this.$el.append this.template this.model.attributes
        return this

  $("#add_one").on 'click', ->
    post = new Post()
    new NewPostView({model: post, el: "#new_area"}).render()
