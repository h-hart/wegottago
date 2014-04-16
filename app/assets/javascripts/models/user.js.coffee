class GottaGo.Models.User extends Backbone.Model
  url: '/users.json'

  toJSON: () ->
    { user: @_cloneAttributes() }

  secureAttributes: [
    'created_at', 'updated_at', 'crop_x'
  ]

  _cloneAttributes: ->
    attributes = _.clone(@attributes)
    for sa in @secureAttributes
      delete attributes[sa]
    _.clone(attributes)