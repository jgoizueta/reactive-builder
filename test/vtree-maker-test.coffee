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

  it "should preserve raw text", ->
    node = VTreeMaker.render -> @raw '&'
    assert.equal node.text, '&'
    node = VTreeMaker.render -> @raw '&amp;'
    assert.equal node.text, '&'
    node = VTreeMaker.render -> @raw '<>\'\"'
    assert.equal node.text, '<>\'\"'

  it "should escape html entities", ->
    node = VTreeMaker.render -> @text '&amp;'
    assert.equal node.text, '&amp;'
    node = VTreeMaker.render -> @text '<>\'\"'
    assert.equal node.text, '<>\'\"'
    node = VTreeMaker.render -> @text '&times;'
    assert.equal node.text, '&times;'

  it "should convert raw html entities", ->
    node = VTreeMaker.render -> @raw '×'
    assert.equal node.text, '×'
    node = VTreeMaker.render -> @raw '&times;'
    assert.equal node.text, '×'
