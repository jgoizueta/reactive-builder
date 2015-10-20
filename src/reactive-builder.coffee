diff = require('virtual-dom/diff')
patch = require('virtual-dom/patch')
createElement = require('virtual-dom/create-element')
VTreeMaker = require './vtree-maker'

class ReactiveBuilder
  constructor: (view) ->
    @view = view
    @tree = null
    @element = null
    @external = false

  @external: (view) ->
    reactive = new ReactiveBuilder(view)
    reactive.external = true
    reactive

  update: (args...) ->
    if !@tree?
      # create element
      @tree = @render args...
      @element = createElement @tree
    else
      # update element
      new_tree = @render args...
      patches = diff @tree, new_tree
      @element = patch @element, patches
      @tree = new_tree
    @element

  render: (args...) ->
    if @external
      VTreeMaker.render_external @view, args...
    else
      VTreeMaker.render @view, args...

module.exports = ReactiveBuilder
