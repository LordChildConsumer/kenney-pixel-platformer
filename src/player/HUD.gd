extends CanvasLayer

onready var valuable_counter = $ValuableCounter
onready var health_bar = $HealthBar

#
# Connect signals
#
func _ready():
	PlayerStats.connect("update_hud", self, "_on_HUD_Update")


func _on_HUD_Update():
	valuable_counter.text = (
		"Coins: %s\nGems: %s" % [PlayerStats.coins, PlayerStats.gems]
	)
	
	health_bar.value = PlayerStats.health
	
	if PlayerStats.health <= 0:
		self.get_parent()._kill_player()
