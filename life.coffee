
window.coffeeLife = new Object()

initGrid = (w,h) -> 
	status = ["dead", "alive"]
	coffeeLife.grid = new Object()
	coffeeLife.grid.w = w-1
	coffeeLife.grid.h = h-1
	(coffeeLife.grid[indexRow] = (status[Math.floor(Math.random()+0.1)] for height in [0..h-1]) for indexRow in [0..w-1])
	
	
neighborStatus = (x,y,a,b) ->
	if( (x is a && y is b) or a<=0 or b<=0 or b >= coffeeLife.grid.h or a >= coffeeLife.grid.w)
		return "dead"
	else
		coffeeLife.grid[a][b]
	

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
	if coffeeLife.grid[x][y] is "alive"
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
	newGrid = coffeeLife.grid
	for x in [0..coffeeLife.grid.w]
		for y in [0..coffeeLife.grid.h]
			do =>
			newGrid[x][y] = deadOrAlive(x,y)
	coffeeLife.grid = newGrid

initGraph = (w,h) ->
	document.getElementById('life').innerHTML= "<canvas id=\"lifeCanvas\" width=\"#{w*10}\" height=\"#{h*10}\" > come on life ! </canvas>";
	coffeeLife.context = document.getElementById('lifeCanvas').getContext('2d');

drawCell = (x,y) ->
	if coffeeLife.grid[x][y] is "alive"
		coffeeLife.context.fillStyle = coffeeLife.params.alive;
		coffeeLife.context.fillRect(x*10, y*10, 10, 10);
	else
		coffeeLife.context.fillStyle = coffeeLife.params.dead;
		coffeeLife.context.fillRect(x*10,y*10, 10, 10);

drawGrid = ->
	for x in [0..coffeeLife.grid.w]
		for y in [0..coffeeLife.grid.h]
			do => 
				drawCell(x,y)

drawLoop = ->
	drawGrid()
	nextGeneration()
	setTimeout(drawLoop,100)

coffeeLife.live = (width,height,params = new Object()) ->
	if params.alive is undefined
		params.alive = "black"

	if params.dead is undefined
		params.dead = "white"

	coffeeLife.params = params

	initGrid(width,height)
	initGraph(width,height)
	drawLoop()





