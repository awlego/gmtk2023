extends Control

var main

onready var timer = Timer.new()

var num_employees = 1000

var game_names = {
	"The Ancient Parchments": 0,
	"Realm of Battles": 0,
	"Summons of Responsibility": 0,
	"Murderer's Belief": 0,
	"Major Robbery Vehicle": 0,
	"Last Dream": 0,
	"Deadly Clash": 0,
	"Ultra Plumber Siblings": 0,
	"Ruin": 0,
	"Dwelling Malevolent": 0,
	"Crypt Explorer": 0,
	"Steel Equipment Firm": 0,
	"Fable of Zenda": 0,
	"Semi-Existence": 0,
	"Crimson Deceased Salvation": 0,
	"Murky Spirits": 0,
	"Vast Impact": 0,
	"Frontier Realms": 0,
	"Aura": 0,
	"Demon Might Weep": 0,
	"Deity of Conflict": 0,
	"Quiet Mountain": 0,
	"Empire Souls": 0,
	"Supervise": 0,
	"Lifethriller": 0,
	"Spellcaster": 0,
	"Demonio": 0,
	"Warfield": 0,
	"Wyvern Epoch": 0,
	"Cogs of Combat": 0,
	"Celestial Creation": 0,
	"Two-week Siege": 0,
	"The Remainder of Ours": 0,
	"Undiscovered": 0,
	"Blockcraft": 0,
	"Creature Crossing": 0,
	"The Citizens": 0,
	"Association of Myths": 0,
	"Zenith Tales": 0,
	"Missile Association": 0
}

var rating_dict = {
	"A+": 100,
	"A": 20,
	"A-": 12,
	"B+": 8,
	"B": 4,
	"B-": 2,
	"C": 1,
	"F": 0.5,
}

var valid_ratings = rating_dict.keys()

onready var gamePortfolio

var game_addictiveness = 1
var advertising_multiplier = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.set_wait_time(1)  # Fire every second
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()
	
	gamePortfolio = get_node("Game Portfolio")
	
func _calculate_profit():
	var earnings = gamePortfolio._calculate_total_earnings()
	var expenses = num_employees * 30000
	return earnings - expenses

func _pick_title(my_dictionary):
	var keys = my_dictionary.keys()
	var random_key = keys[randi() % keys.size()]
	my_dictionary[random_key] += 1
	return str(random_key) + " " + str(my_dictionary[random_key])
	
func _create_new_game():
	pass
#	var title = pick_title(game_names)
#	var rating = valid_ratings[int(randi() % len(valid_ratings))] # todo weight this when you buy ratings and by employee happiness
#	var time_left = int(randi() % 120 * advertising_multiplier * game_addictiveness)
#	var earning = str(rating_dict[rating] * randi() % 100 * 10000)
##	gamePortfolio.create_game({title, time_left, rating, earning})
#	announce("Congratulations on releasing " + title + "!")
	
func _main_loop():
	var profit = _calculate_profit()
	main.update_money(profit)
	
func _on_Timer_timeout():
	_main_loop()
	
