$ = jQuery

initGrid = (w,h) -> 
	status = ["dead", "alive"]
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
	if grid[x][y] is "dead"
		true
	else
		false

aliveNeighbors = (x,y) ->
	number = 0
	cell = new Object()
	cell.x = x
	cell.y = y
	for a in [x-1..x+1]
		for b in [y-1..y+1]
			do =>
			if not isNeighborDead(cell,a,b)
				number +=1
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

initGraph = ->
	$("#life").html("<canvas id=\"lifeCanvas\" width=\"800\" height=\"800\" > come on life ! </canvas>")
	window.contexte = document.getElementById('lifeCanvas').getContext('2d');
	window.contexte.fillStyle = "rgba(0,0,0,1)";
	window.contexte.fillRect(0, 0, 100, 100)

drawCell = (x,y) ->
	grid = window.grid
	column = x;
	row = y;
	if grid[column][row] is "alive"
		window.contexte.fillStyle = "rgba(255,255,255,1)";
		window.contexte.fillRect(column, row, 1, 1);
	else
		window.contexte.fillStyle = "rgba(0,0,0,1)";
		window.contexte.fillRect(column,row, 1, 1);

drawGrid = ->
	for x in [1..grid.w]
		for y in [1..grid.h]
			do => 
			drawCell(x,y)

drawLoop = =>
	drawGrid()
	nextGeneration()
	setTimeout(drawLoop,10)

mainPgm = =>
	width = 100
	height = 100
	initGrid(width,height)
	initGraph()
	drawLoop()

mainPgm()






