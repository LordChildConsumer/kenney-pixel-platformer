extends Node

# --- Misc Signals ---
signal quit_game()


# --- Management Signals ---
signal switch_scene(new_scene)
signal reload_scene()


# --- Player Signals ---
signal coin_collected()
signal gem_collected()

signal coin_purchase(cost)
signal gem_purchase(cost)

signal player_hurt(value)
signal player_healed(value)
signal player_killed()

signal level_complete()
