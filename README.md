CoffeeLife
==========

Conway's Game of Life in coffee script

PREVIEW
=======

[Click here to have a look at the result !](http://cedias.github.com/CoffeeLife)

RULES
=======
The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

	Any live cell with fewer than two live neighbours dies, as if caused by under-population.
	Any live cell with two or three live neighbours lives on to the next generation.
	Any live cell with more than three live neighbours dies, as if by overcrowding.
	Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.

USAGE
======
include life.js in your webpage

	`<script src="life.js"> </script>`

add a div which id is "life" for the canvas

	`<div id="life"></div>`

call the function (it's in your window object) <-- This isn't right, right ?

	`<script type="text/javascript"> coffeeLife(65,25); </script>`

TODO
=====

1. Add some options for custom use
2. get the thing out of window ?
3. cleaner syntax !

LICENCE & DISCLAIMER
==================
You can use this code if you like, no restrictions!
Be careful somethings are probably wrong since i've never tried Coffee Script before.



