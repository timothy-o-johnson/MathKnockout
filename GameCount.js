var games = ['1234']

var gameCombo = ''

function getGameCombos (games) {
  var a
  var b
  var c
  var d
  var gameCount = 1

  for (a = 1; a < 10; a++) {
    for (b = 2; b < 10; b++) {
      for (c = 3; c < 10; c++) {
        for (d = 4; d < 10; d++) {
          gameCombo = sortAndJoin(a, b, c, d)
          if (containsNoDuplicates(gameCombo) && gameComboDoesNotExist(gameCombo, games)) {
            console.log(gameCombo)
            games.push(gameCombo)
            gameCount++
          }
        }
      }
    }
  }
  console.log(`gameCount = ${gameCount}`)
}

getGameCombos(games)

console.log(games)

function prepForTest (a, b, c, d) {
  var gameCombo = [a, b, c, d]

  gameCombo.sort((a, b) => {
    return a - b
  })
  gameCombo = gameCombo.join('')

  return gameCombo
}

function gameComboDoesNotExist (gameCombo, games) {
  var exists = true
  games.forEach(function (combo) {
    if (gameCombo === combo) {
      exists = false
    }
  })
  return exists
}

function containsNoDuplicates (gameCombo) {
  var comboMap = {}

  for (var i = 0; i < gameCombo.length; i++) {
    var value = gameCombo[i]
    if (comboMap[value]) {
      return true
    } else {
      comboMap[value] = 1
    }
  }
  return false
}

gameCombo = [1, 2, 3, 4]

var hasDuplicate = containsNoDuplicates(gameCombo)

hasDuplicate
