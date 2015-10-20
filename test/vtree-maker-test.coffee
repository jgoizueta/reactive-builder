assert = require "assert"
assertEqualDom = require "./lib/assert-equal-dom.js"
VNode = require 'virtual-dom/vnode/vnode'
VText = require 'virtual-dom/vnode/vtext'

describe 'VTreeMaker', ->
  global.require_lib  = (name) -> require(__dirname + '/../lib/' + name)
  VTreeMaker = require_lib 'vtree-maker'

  it "should work", ->
    node = VTreeMaker.render ->
      @p id: 'paragraph', =>
        @text 'contents'
    text = new VText 'contents'
    expected = new VNode('p', id: 'paragraph', [text])
    assertEqualDom assert, node, expected
