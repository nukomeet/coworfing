class C.PlacesSerachForm extends Backbone.View
  el: $('#places')
  
  events:
    "click #submit_location" : "submit_form"
  
  initialize: ->    
    _.bindAll @
    @form = @.$el.find("#search_form")
    @form_action = @form.attr("action")
    @search_input = @.$el.find("#location")
    @search_input.geocomplete()
  
  update_form_action: () =>
    location = @search_input.val().replace(",", "-").split(" ").join("-")
    @form.attr("action", @form_action + "/" + location)
    
  submit_form: (e) =>
    e.preventDefault()
    @.update_form_action()
    @search_input.attr("disabled", "disabled")
    @form.find("[name='utf8']").attr("disabled", "disabled")
    @form.submit()
