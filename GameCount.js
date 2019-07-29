// Javascript file used to calculate all the possible game combinations


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
  return games
}

console.log(JSON.stringify(getGameCombos(games)))

console.log(games)

function sortAndJoin (a, b, c, d) {
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
      return false
    } else {
      comboMap[value] = 1
    }
  }
  return true
}

gameCombo = [1, 2, 3, 4]

var hasDuplicate = containsNoDuplicates(gameCombo)

const gameCombos = [
  '1234',
  '1235',
  '1236',
  '1237',
  '1238',
  '1239',
  '1245',
  '1246',
  '1247',
  '1248',
  '1249',
  '1256',
  '1257',
  '1258',
  '1259',
  '1267',
  '1268',
  '1269',
  '1278',
  '1279',
  '1289',
  '1345',
  '1346',
  '1347',
  '1348',
  '1349',
  '1356',
  '1357',
  '1358',
  '1359',
  '1367',
  '1368',
  '1369',
  '1378',
  '1379',
  '1389',
  '1456',
  '1457',
  '1458',
  '1459',
  '1467',
  '1468',
  '1469',
  '1478',
  '1479',
  '1489',
  '1567',
  '1568',
  '1569',
  '1578',
  '1579',
  '1589',
  '1678',
  '1679',
  '1689',
  '1789',
  '2345',
  '2346',
  '2347',
  '2348',
  '2349',
  '2356',
  '2357',
  '2358',
  '2359',
  '2367',
  '2368',
  '2369',
  '2378',
  '2379',
  '2389',
  '2456',
  '2457',
  '2458',
  '2459',
  '2467',
  '2468',
  '2469',
  '2478',
  '2479',
  '2489',
  '2567',
  '2568',
  '2569',
  '2578',
  '2579',
  '2589',
  '2678',
  '2679',
  '2689',
  '2789',
  '3456',
  '3457',
  '3458',
  '3459',
  '3467',
  '3468',
  '3469',
  '3478',
  '3479',
  '3489',
  '3567',
  '3568',
  '3569',
  '3578',
  '3579',
  '3589',
  '3678',
  '3679',
  '3689',
  '3789',
  '4567',
  '4568',
  '4569',
  '4578',
  '4579',
  '4589',
  '4678',
  '4679',
  '4689',
  '4789',
  '5678',
  '5679',
  '5689',
  '5789',
  '6789'
]

console.log(gameCombos.length)

