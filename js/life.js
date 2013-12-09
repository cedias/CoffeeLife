// Generated by CoffeeScript 1.4.0
(function() {
  var aliveNeighbors, deadOrAlive, drawCell, drawGrid, drawLoop, initGraph, initGrid, neighborStatus, nextGeneration;

  window.coffeeLife = new Object();

  initGrid = function(w, h) {
    var height, indexRow, status, _i, _ref, _results;
    status = ["dead", "alive"];
    coffeeLife.grid = new Object();
    coffeeLife.grid.w = w - 1;
    coffeeLife.grid.h = h - 1;
    _results = [];
    for (indexRow = _i = 0, _ref = w - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; indexRow = 0 <= _ref ? ++_i : --_i) {
      _results.push(coffeeLife.grid[indexRow] = (function() {
        var _j, _ref1, _results1;
        _results1 = [];
        for (height = _j = 0, _ref1 = h - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; height = 0 <= _ref1 ? ++_j : --_j) {
          _results1.push(status[Math.floor(Math.random() + 0.1)]);
        }
        return _results1;
      })());
    }
    return _results;
  };

  neighborStatus = function(x, y, a, b) {
    if ((x === a && y === b) || a <= 0 || b <= 0 || b >= coffeeLife.grid.h || a >= coffeeLife.grid.w) {
      return "dead";
    } else {
      return coffeeLife.grid[a][b];
    }
  };

  aliveNeighbors = function(x, y) {
    var a, b, number, _fn, _i, _j, _ref, _ref1, _ref2, _ref3,
      _this = this;
    number = 0;
    for (a = _i = _ref = x + 1, _ref1 = x - 1; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; a = _ref <= _ref1 ? ++_i : --_i) {
      _fn = function() {
        if (neighborStatus(x, y, a, b) === "alive") {
          return number += 1;
        } else {
          return number += 0;
        }
      };
      for (b = _j = _ref2 = y - 1, _ref3 = y + 1; _ref2 <= _ref3 ? _j <= _ref3 : _j >= _ref3; b = _ref2 <= _ref3 ? ++_j : --_j) {
        _fn();
      }
    }
    return number;
  };

  deadOrAlive = function(x, y) {
    var number;
    number = aliveNeighbors(x, y);
    if (coffeeLife.grid[x][y] === "alive") {
      if (number < 2 || number > 3) {
        return "dead";
      } else {
        return "alive";
      }
    } else {
      if (number === 3) {
        return "alive";
      } else {
        return "dead";
      }
    }
  };

  nextGeneration = function() {
    var newGrid, x, y, _fn, _i, _j, _ref, _ref1,
      _this = this;
    newGrid = coffeeLife.grid;
    for (x = _i = 0, _ref = coffeeLife.grid.w; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
      _fn = function() {};
      for (y = _j = 0, _ref1 = coffeeLife.grid.h; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
        _fn();
        newGrid[x][y] = deadOrAlive(x, y);
      }
    }
    return coffeeLife.grid = newGrid;
  };

  initGraph = function(w, h) {
    document.getElementById('life').innerHTML = "<canvas id=\"lifeCanvas\" width=\"" + (w * 10) + "\" height=\"" + (h * 10) + "\" > come on life ! </canvas>";
    return coffeeLife.context = document.getElementById('lifeCanvas').getContext('2d');
  };

  drawCell = function(x, y) {
    if (coffeeLife.grid[x][y] === "alive") {
      coffeeLife.context.fillStyle = coffeeLife.params.alive;
      return coffeeLife.context.fillRect(x * 10, y * 10, 10, 10);
    } else {
      coffeeLife.context.fillStyle = coffeeLife.params.dead;
      return coffeeLife.context.fillRect(x * 10, y * 10, 10, 10);
    }
  };

  drawGrid = function() {
    var x, y, _i, _ref, _results;
    _results = [];
    for (x = _i = 0, _ref = coffeeLife.grid.w; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
      _results.push((function() {
        var _j, _ref1, _results1,
          _this = this;
        _results1 = [];
        for (y = _j = 0, _ref1 = coffeeLife.grid.h; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
          _results1.push((function() {
            return drawCell(x, y);
          })());
        }
        return _results1;
      }).call(this));
    }
    return _results;
  };

  drawLoop = function() {
    drawGrid();
    nextGeneration();
    return setTimeout(drawLoop, 100);
  };

  coffeeLife.live = function(width, height, params) {
    if (params == null) {
      params = new Object();
    }
    if (params.alive === void 0) {
      params.alive = "black";
    }
    if (params.dead === void 0) {
      params.dead = "white";
    }
    coffeeLife.params = params;
    initGrid(width, height);
    initGraph(width, height);
    return drawLoop();
  };

}).call(this);
