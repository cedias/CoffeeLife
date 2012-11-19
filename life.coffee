$ = jQuery

aliveNeighbors = (grid, cell) ->
	number = 0
	number +=1  unless grid[cell-1] is "dead"
	number +=1  unless grid[cell+1] is "dead"
	number +=1  unless grid[cell-800] is "dead"
	number +=1  unless grid[cell-800 - 1] is "dead"
	number +=1  unless grid[cell-800 + 1] is "dead"
	number +=1  unless grid[cell+800] is "dead"
	number +=1  unless grid[cell+800 - 1] is "dead"
	number +=1  unless grid[cell+800 + 1] is "dead"
	number
	
 
	
deadOrAlive = (grid, cell) ->
	number = aliveNeighbors(grid,cell)
	if grid[cell] is "alive"
		if number < 2 or number > 3
			grid[cell] = "dead"
	else
		if number is 3
			grid[cell] = "alive"
	grid[cell]
	
nextGeneration = (grid) ->
	newGrid = grid
	deadOrAlive(newGrid,cell) for cell in [gridSize..0]
	newGrid

graphInit = ->
	$("#life").html("<canvas id=\"lifeCanvas\" width=\"800\" height=\"800\" > come on life ! </canvas>")
	contexte = document.getElementById('lifeCanvas').getContext('2d');
	contexte.fillStyle = "rgba(0,0,0,1)";
	contexte.fillRect(0, 0, 802, 802);
	contexte.save()
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
	contexte.save()
	contexte

drawLoop = (contexte, grid) ->
	drawGrid(contexte,grid)
	grid = nextGeneration grid

gridSize = 40000
status = ["dead", "alive"]
grid = (status[Math.floor(Math.random()+0.1)] for spot in [gridSize..0])
contexte = graphInit()
drawLoop(contexte, grid) for spot in [100000..0]





