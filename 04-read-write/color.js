
var setColor = function(color) {
  console.log("setting new color:", color)
  document.body.style.background = color
}

var loadColor = function() {
  fetch('color.json')
    .then(function(response) {
      return response.json()
    }).then(function(json) {
      console.log('parsed json', json)
      setColor(json.color)
    }).catch(function(ex) {
      console.log('parsing failed', ex)
    })
}

var promptColor = function() {
  var newColor = prompt("What color do you want?")
  setColor(newColor)
  writeColor(newColor)
}

var writeColor = function(newColor) {
  fetch('color.json', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      color: newColor,
    })
  }).catch(function(ex) {
    console.log('saving failed', ex)
  })
}

// run it on page load
loadColor()

document.getElementById('color-button').onclick = promptColor
