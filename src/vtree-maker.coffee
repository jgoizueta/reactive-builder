_ = require 'underscore-plus'
VNode = require 'virtual-dom/vnode/vnode'
VText = require 'virtual-dom/vnode/vtext'
HtmlMaker = require 'html-maker'

class ReactiveMaker extends HtmlMaker
  constructor: ->
    @nodes = []
    @tags = []

  build: ->
    if @nodes.length > 1
      new VNode('div', {}, @nodes)
    else
      @nodes[0]

  endTag: (name) ->
    @addNode new VNode @tags.pop()...

  addNode: (node) ->
    if @tags.length > 0
      current_tag = @tags[@tags.length - 1]
      children = current_tag[current_tag.length - 1]
      children.push node
    else
      @nodes.push node

  openTag: (name, attributes) ->
    attributes ?= {}
    node_properties = {}
    node_attributes = {}
    for attribute, value of attributes when value?
      switch attribute
        when 'data'
          data = value
          if typeof(data) == 'object'
            data = _.mapObject data, (k, v) -> ['data-'+_.dasherize(k), v]
            node_attributes = _.extend node_attributes, data
          else
            node_attributes.data = data
        when 'style'
          style = value
          if typeof(style) == 'object'
            node_properties[attribute] = value
          else
            node_attributes[attribute] = value
        when 'class'
          node_properties.className = value
        when 'id'
          node_properties[attribute] = value
        else
          node_attributes[attribute] = value
    unless _.isEmpty node_attributes
      node_properties.attributes = node_attributes
    @tags.push [name, node_properties, []]

  closeTag: (name) ->
    @endTag name

  rawText: (string) ->
    @addNode new VText string

module.exports = ReactiveMaker
