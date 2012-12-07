$ = jQuery

initGrid = (w,h) -> 
	status = ["dead", "alive"]
	window.grid = new Object()
	window.grid.w = w-1
	window.grid.h = h-1
	(window.grid[indexRow] = (status[Math.floor(Math.random()+0.1)] for height in [0..h-1]) for indexRow in [0..w-1])
	
	
neighborStatus = (x,y,a,b) ->
	if( (x is a && y is b) or a<=0 or b<=0 or b >= window.grid.h or a >= window.grid.w)
		return "dead"
	else
		window.grid[a][b]
	

aliveNeighbors = (x,y) ->
	number = 0
	for a in [x+1..x-1]
		for b in [y-1..y+1]
			do =>
				if neighborStatus(x,y,a,b) is "alive"
					number +=1
				else
					number +=0
	number

deadOrAlive = (x,y) ->
	number = aliveNeighbors(x,y)
	if window.grid[x][y] is "alive"
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
	for x in [0..grid.w]
		for y in [0..grid.h]
			do =>
			newGrid[x][y] = deadOrAlive(x,y)
	window.grid = newGrid

initGraph = (w,h) ->
	$("#life").html("<canvas id=\"lifeCanvas\" width=\"#{w*10}\" height=\"#{h*10}\" > come on life ! </canvas>")
	window.contexte = document.getElementById('lifeCanvas').getContext('2d');
	window.contexte.fillStyle = "rgba(12,12,12,1)";
	window.contexte.fillRect(0, 0, w*16, h*16)

drawCell = (x,y) ->
	if window.grid[x][y] is "alive"
		window.contexte.fillStyle = "rgba(255,255,255,1)";
		window.contexte.fillRect(x*10, y*10, 10, 10);
	else
		window.contexte.fillStyle = "rgba(0,0,0,1)";
		window.contexte.fillRect(x*10,y*10, 10, 10);

drawGrid = ->
	for x in [0..grid.w]
		for y in [0..grid.h]
			do => 
				drawCell(x,y)

drawLoop = =>
	drawGrid()
	nextGeneration()
	setTimeout(drawLoop,100)

window.coffeeLife = (width,height) =>
	initGrid(width,height)
	initGraph(width,height)
	drawLoop()





