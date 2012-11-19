// Generated by CoffeeScript 1.4.0
(function() {
  var $, aliveNeighbors, contexte, deadOrAlive, drawCell, drawGrid, drawLoop, graphInit, grid, gridSize, nextGeneration, spot, status, _i;

  $ = jQuery;

  aliveNeighbors = function(grid, cell) {
    var number;
    number = 0;
    if (grid[cell - 1] !== "dead") {
      number += 1;
    }
    if (grid[cell + 1] !== "dead") {
      number += 1;
    }
    if (grid[cell - 800] !== "dead") {
      number += 1;
    }
    if (grid[cell - 800 - 1] !== "dead") {
      number += 1;
    }
    if (grid[cell - 800 + 1] !== "dead") {
      number += 1;
    }
    if (grid[cell + 800] !== "dead") {
      number += 1;
    }
    if (grid[cell + 800 - 1] !== "dead") {
      number += 1;
    }
    if (grid[cell + 800 + 1] !== "dead") {
      number += 1;
    }
    return number;
  };

  deadOrAlive = function(grid, cell) {
    var number;
    number = aliveNeighbors(grid, cell);
    if (grid[cell] === "alive") {
      if (number < 2 || number > 3) {
        grid[cell] = "dead";
      }
    } else {
      if (number === 3) {
        grid[cell] = "alive";
      }
    }
    return grid[cell];
  };

  nextGeneration = function(grid) {
    var cell, newGrid, _i;
    newGrid = grid;
    for (cell = _i = gridSize; gridSize <= 0 ? _i <= 0 : _i >= 0; cell = gridSize <= 0 ? ++_i : --_i) {
      deadOrAlive(newGrid, cell);
    }
    return newGrid;
  };

  graphInit = function() {
    var contexte;
    $("#life").html("<canvas id=\"lifeCanvas\" width=\"800\" height=\"800\" > come on life ! </canvas>");
    contexte = document.getElementById('lifeCanvas').getContext('2d');
    contexte.fillStyle = "rgba(0,0,0,1)";
    contexte.fillRect(0, 0, 802, 802);
    contexte.save();
    return contexte;
  };

  drawCell = function(contexte, grid, cell) {
    var column, row;
    column = cell % 800;
    row = (cell - column) / 800;
    if (grid[cell] === "alive") {
      contexte.fillStyle = "rgba(255,255,255,1)";
      return contexte.fillRect(column * 16 + 1, 1 + row * 16, 16, 16);
    } else {
      contexte.fillStyle = "rgba(0,0,0,1)";
      return contexte.fillRect(column * 16 + 1, 1 + row * 16, 16, 16);
    }
  };

  drawGrid = function(contexte, grid) {
    var cell, _i;
    for (cell = _i = gridSize; gridSize <= 0 ? _i <= 0 : _i >= 0; cell = gridSize <= 0 ? ++_i : --_i) {
      drawCell(contexte, grid, cell);
    }
    contexte.save();
    return contexte;
  };

  drawLoop = function(contexte, grid) {
    drawGrid(contexte, grid);
    return grid = nextGeneration(grid);
  };

  gridSize = 40000;

  status = ["dead", "alive"];

  grid = (function() {
    var _i, _results;
    _results = [];
    for (spot = _i = gridSize; gridSize <= 0 ? _i <= 0 : _i >= 0; spot = gridSize <= 0 ? ++_i : --_i) {
      _results.push(status[Math.floor(Math.random() + 0.1)]);
    }
    return _results;
  })();

  contexte = graphInit();

  for (spot = _i = 100000; _i >= 0; spot = --_i) {
    drawLoop(contexte, grid);
  }

}).call(this);