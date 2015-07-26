#= require jquery
#= require jquery_ujs
#= require handlebars
#= require ember
#= require ember-data
#= require active-model-adapter
#= require_self
#= require walnut
#= require_tree ./controllers
#= require_tree ./models
#= require_tree ./views
#= require_tree ./adapters
#= require_tree ./routes


# for more details see: http://emberjs.com/guides/application/
window.Walnut = Ember.Application.create()

Walnut.ProjectsRoute = Ember.Route.extend
	model: ->
		 @get('store').findAll('project')