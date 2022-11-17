extends Node

const max_health := 6

signal update_hud()

var coins := 0
var gems := 0
var health := 6

#
# Connect various signals
#
func _ready():
	EventBus.connect("coin_collected", self, "_on_Coin_Collection")
	EventBus.connect("gem_collected", self, "_on_Gem_Collection")
	EventBus.connect("coin_purchase", self, "_on_Coin_Purchase")
	EventBus.connect("gem_purchase", self, "_on_Gem_Purchase")
	EventBus.connect("player_hurt", self, "_on_Player_Hurt")
	EventBus.connect("player_healed", self, "_on_Player_Heal")
	

#
# Collection
#
func _on_Coin_Collection():
	coins += 1
	emit_signal("update_hud")

func _on_Gem_Collection():
	gems += 1
	emit_signal("update_hud")

#
# Purchase
#
func _on_Coin_Purchase(value):
	coins -= value
	emit_signal("update_hud")

func _on_Gem_Purchase(value):
	gems -= value
	emit_signal("update_hud")

#
# Health modification
#
func _on_Player_Hurt(value):
	health -= value
	emit_signal("update_hud")
	

func _on_Player_Heal(value):
	health += value
	emit_signal("update_hud")
