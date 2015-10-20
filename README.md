# reactive-builder

This is an npm module to
define reactive DOM elements with
(virtual-dom)[https://github.com/Matt-Esch/virtual-dom]
and (html-maker)[https://github.com/jgoizueta/html-maker],
intended for CoffeScript use.

## Usage

Using `ReactiveBuilder` a view is defined exactly as
with (html-maker)[https://github.com/jgoizueta/html-maker].

The resulting object has an `update` method which is called
passing arguments for the view. This method returns a DOM element.
Each time it is called again the element is efficiently updated
by using (virtual-dom)[https://github.com/Matt-Esch/virtual-dom].

## Example

```coffee
ReactiveBuilder = require './reactive-builder'

double_view = (count) ->
  @p class: 'doubler', =>
    @text String(count*2)

reactive = new ReactiveBuilder (count) ->
  @div String(count),
    id: 'counter'
    class: 'counting-number'
    style:
      textAlign: 'center'
      lineHeight: 100 + count + 'px'
      border: '1px solid red'
      width: 100 + count + 'px'
      height: 100 + count + 'px'
  @div class: 'dubler-container', =>
    @render double_view, count

count = 0
document.body.appendChild reactive.update count
setInterval (->
  count++
  reactive.update count
), 1000
```
