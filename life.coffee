$ = jQuery

initGrid = (w,h) -> 
	window.grid = new Object()
	window.grid.w = w
	window.grid.h = h
	(window.grid[indexRow] = (status[Math.floor(Math.random()+0.1)] for height in [1..h]) for indexRow in [1..w])
	
	
isNeighborDead =(cell,x,y) ->
	grid = window.grid
	if(cell.x == x && cell.y == y)
		true
	if(x<1)
		x = grid.h
	if(y<1)
		y = grid.w
	if(y>=grid.w)
		y=1
	if(x>=grid.h)
		x =1
	grid[x][y] is "dead"

aliveNeighbors = (x,y) ->
	number = 0
	cell = new Object()
	cell.x = x
	cell.y = y
	for a in [x-1..x+1]
		for b in [y-1..y+1]
			do =>
			number += 1 if not isNeighborDead(cell,a,b)
	number

deadOrAlive = (x,y) ->
	grid = window.grid
	number = aliveNeighbors(x,y)
	if grid[x][y] is "alive"
		if number < 2 or number > 3
			"dead"
		else
			"alive"
	else
		if number is 3
			"alive"
		else
			"dead"

	
nextGeneration = () ->
	newGrid = window.grid
	grid = window.grid
	console.log(grid.w)
	for x in [1..grid.w]
		for y in [1..grid.h]
			do =>
			newGrid[x][y] = deadOrAlive(x,y)
	window.grid = newGrid
	console.log(newGrid)

graphInit = ->
	$("#life").html("<canvas id=\"lifeCanvas\" width=\"800\" height=\"800\" > come on life ! </canvas>")
	contexte = document.getElementById('lifeCanvas').getContext('2d');
	contexte.fillStyle = "rgba(0,0,0,1)";
	contexte.fillRect(0, 0, 802, 802)
	contexte

drawCell = (contexte,grid,cell) ->
	column = cell % 800;
	row = (cell - column) / 800;
	if grid[cell] is "alive"
		contexte.fillStyle = "rgba(255,255,255,1)";
		contexte.fillRect(column*16+1, 1 + row*16, 16, 16);
	else
		contexte.fillStyle = "rgba(0,0,0,1)";
		contexte.fillRect(column*16+1, 1 + row*16, 16, 16);

drawGrid = (contexte, grid) ->
	drawCell(contexte,grid,cell) for cell in [gridSize..0]

drawLoop = =>
	drawGrid(contexte,grid)
	window.grid = nextGeneration grid
	alert(grid)
	setTimeout(drawLoop,500)
	



width = 200
height = 200
status = ["dead", "alive"]
initGrid(width,height)
console.log(window.grid)
setInterval(nextGeneration,1000);








