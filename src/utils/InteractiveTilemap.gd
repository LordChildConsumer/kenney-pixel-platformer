extends TileMap
class_name InteractiveTilemap

export(Dictionary) var TILE_SCENES := {
	#0: preload("res://src/items/Gem.tscn")
}


func _ready():
	yield(get_tree(), "idle_frame")
	_replace_tiles_with_scenes()



func _replace_tiles_with_scenes(scene_dictionary: Dictionary = TILE_SCENES):
	for tile_pos in get_used_cells():
		var tile_id = get_cell(tile_pos.x, tile_pos.y)
		
		if scene_dictionary.has(tile_id):
			var object_scene = scene_dictionary[tile_id]
			_replace_tile_with_object(tile_pos, object_scene)

#
# Replaces the tiles in the scene with their specific objects.
# Params:
#	tile_pos: Where the tile actually is
#	object_scene: What the object actually is
#	parent: The node to instance the object as a child of
#
func _replace_tile_with_object(tile_pos: Vector2, object_scene: PackedScene, parent: Node = self.get_parent()):
	# Clear the tile in the Tilemap
	if get_cellv(tile_pos) != INVALID_CELL:
		set_cellv(tile_pos, -1)
		update_bitmask_region() # Keeps auto-tile from breaking
	
	# Spawn the object
	if object_scene:
		var obj = object_scene.instance()
		var obj_pos = (map_to_world(tile_pos) * 2) + cell_size
		
		parent.add_child(obj)
		obj.global_position = obj_pos
	
