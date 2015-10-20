# To test in browser:
#    grunt coffee
#    browserify -t coffeeify main.coffee > bundle.js
#    open index.html
#
# This requires:
#
#     npm install -g browserify

ReactiveBuilder = require '../../lib/reactive-builder'

# double_view = (_, count) ->
#   _.p class: 'doubler', =>
#     _.text String(count*2)
#
# count = 0
# reactive = ReactiveBuilder.external (_, count) ->
#   _.div String(count),
#     id: 'counter'
#     class: 'counting-number'
#     name: 'Counter'
#     style:
#       textAlign: 'center'
#       lineHeight: 100 + count + 'px'
#       border: '1px solid red'
#       width: 100 + count + 'px'
#       height: 100 + count + 'px'
#     data:
#       count: count
#       countName: 'xyz'
#     abc: '123'
#   _.div class: 'doubler-container', =>
#     double_view _, count

double_view = (count) ->
  @p class: 'doubler', =>
    @text String(count*2)

count = 0
reactive = new ReactiveBuilder (count) ->
  @div String(count),
    id: 'counter'
    class: 'counting-number'
    name: 'Counter'
    style:
      textAlign: 'center'
      lineHeight: 100 + count + 'px'
      border: '1px solid red'
      width: 100 + count + 'px'
      height: 100 + count + 'px'
    data:
      count: count
      countName: 'xyz'
    abc: '123'
  @div class: 'doubler-container', =>
    @render double_view, count

document.body.appendChild reactive.update count
setInterval (->
  count++
  reactive.update count
), 1000
