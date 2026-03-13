extends Node

var map_data = {}
@export var gridmap : GridMap

var terrain_lookup = {
	0: preload("res://game/Map/Terrain/TerrainData/Rock.tres"),
	1: preload("res://game/Map/Terrain/TerrainData/Sand1.tres"),
	2: preload("res://game/Map/Terrain/TerrainData/Sand2.tres")
}

func _ready():
	build_map_data()

func build_map_data():

	map_data.clear()

	for cell in gridmap.get_used_cells():

		var item = gridmap.get_cell_item(cell)

		# ignore empty cells
		if item == -1:
			continue

		# ignore decorations
		if !terrain_lookup.has(item):
			continue

		var terrain = terrain_lookup[item]

		# ignore non-walkable terrain
		if !terrain.walkable:
			continue

		var column = Vector2i(cell.x, cell.z)

		# if column doesn't exist yet
		if !map_data.has(column):

			map_data[column] = {
				"height": cell.y,
				"terrain": terrain
			}

		else:

			# update only if this tile is higher
			if cell.y > map_data[column]["height"]:

				map_data[column]["height"] = cell.y
				map_data[column]["terrain"] = terrain
