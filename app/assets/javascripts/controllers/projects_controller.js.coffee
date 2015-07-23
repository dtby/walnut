Walnut.ProjectsNewController = Ember.ObjectController.extend(
  actions:
    create_project: ->
      record = @get('store').createRecord('project',
           {name: this.get('name'), description: this.get('description')}
          )
      record.save()
      @transitionTo('index')
)

Walnut.ProjectController = Ember.ObjectController.extend(
  isEditing: false
  actions:
	  edit: ->
	    @set "isEditing", true

	  removeProject: ->
	    if (window.confirm("确定删除该项目?"))
	    	model = @get('model')
	    	model.deleteRecord()
	    model.save()

	  doneEditing: ->
	    @set "isEditing", false
	    @get('model').save()

)

