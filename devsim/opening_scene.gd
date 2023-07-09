extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var energy_meter
var computer_boot_flag = 0
var removed = false
#onready var removable = get_node("$VSplitContainer/HSplitContainer2/HelloWorld")
var pf
var asm
var music_skill = 0.1
var main
var first_sleep_appear = false
var sleeping = true
var tired = false
var programming_skill = 0
var coffee_penalty = 0
var coffee_phrases = [
"Sipping on some lovely coffee",
"Really need my energy back",
"Go Beans Go",
"Never Sleep Again!",
"Is this really still working?",
"Ah, the perfect morning brew.",
"A sip of liquid motivation.",
"Coffee, my faithful companion.",
"Embracing the caffeine's embrace.",
"Fueling my day, one sip at a time.",
"Awake and alive with every drop.",
"Coffee: the elixir of productivity.",
"Inhaling the aroma, exhaling the stress.",
"Life's challenges, meet my coffee-fueled resolve.",
"Savoring the warmth, embracing the energy.",
"A burst of flavor, a surge of focus.",
"Coffee coursing through my veins.",
"This mug holds the secrets of my ambition.",
"One sip closer to conquering the day.",
"My morning ritual, my caffeinated escape.",
"The world awakens as I take a sip.",
"Brewing dreams, one cup at a time.",
"Coffee: the nectar of early mornings.",
"Savoring the black gold, feeling alive.",
"Awake, alert, and ready to conquer.",
"Be like coffee, bitter",
"Bitter salvation in a cup.",
"Grim determination fueled by coffee.",
"Finding solace in the depths of this brew.",
"Each sip, a respite from life's burdens.",
"Embracing the darkness, one caffeine fix at a time.",
"Coffee: the anchor that keeps me afloat.",
"Warding off exhaustion with every bitter gulp.",
"In this cup, a temporary escape from reality.",
"Brewing resilience to face the day's challenges.",
"Dark elixir, fortifying my spirit.",
"Amidst chaos, coffee brings me back to center.",
"Waking up to the embrace of bitter salvation.",
"Black coffee, a shield against the world's woes.",
"Nourishing my weary soul with each caffeine infusion.",
"Finding strength in the depths of this dark potion.",
"Coffee, my ally in the battle against weariness.",
"In this cup, I find the courage to persevere.",
"Savoring the bitterness, finding beauty in the struggle.",
"A shot of determination, coursing through my veins.",
"Amidst adversity, coffee stands as my constant companion."
]

var personal_status = "Well Rested and Feeling Ready for Game Jam"

var count = 0
var sound_idx = 0
var music_note_idx = 0
var music_note_list = []

var games_made_counter = 0
var games_sold = 0
var marketing_bonus = 0

var artist_hired = false
var musician_hired = false
var dev_hired = false

onready var art_progress = $VSplitContainer/H/v1/Art
onready var music_progress = $VSplitContainer/H/v2/Music
onready var code_progress = $VSplitContainer/H/v3/Code
onready var game_progress = $VSplitContainer/GameProgress/Percent


# Called when the node enters the scene tree for the first time.
func _ready():
	$VSplitContainer/login_itch.hide()
	$VSplitContainer/GameProgress/GameCompletion2.hide()
	$VSplitContainer/GameProgress/Percent.hide()
	$VSplitContainer/H/v1.hide()
	$VSplitContainer/H/v2.hide()
	$VSplitContainer/H/v3.hide()
	$VSplitContainer/HSplitContainer/EnergyMeter.hide()
	$VSplitContainer/HSplitContainer/Label.hide()
	$VSplitContainer/CoffeeSleepBox/DrinkCoffee.hide()
	$VSplitContainer/CoffeeSleepBox/Sleep.hide()
	$VSplitContainer/BootComputer.hide()
	$VSplitContainer/HSplitContainer2/Label.hide()
	$VSplitContainer/HSplitContainer2/HelloWorld.hide()
	$VSplitContainer/HSplitContainer2/HelloWorld.max_length = 20
	pf = ProjectFactory.new()
	asm = AudioStreamManager.new()
	self.add_child(pf)
	self.add_child(asm)
	$VSplitContainer/HBoxContainer2/Art.hide()
	$VSplitContainer/HBoxContainer2/Music.hide()
	$VSplitContainer/HBoxContainer2/MusicNotes.hide()
	$VSplitContainer/HBoxContainer2/TextureRect.hide()
	$VSplitContainer/HBoxContainer2/Coding/Code.hide()
	$VSplitContainer/HBoxContainer2/Coding/Study.hide()
	$VSplitContainer/HBoxContainer/Eat.hide()

	$VSplitContainer/HBoxContainer/Socialize.hide()
	sleeping = false
	
	$VSplitContainer/Status.text = personal_status
	main.announce("Wake up...")
	main.announce("Another day of videogames!")
	main.announce("The newest game jam just ended, so many things to play!")
	# :D
	# TODO add happy face here (or happy stat)
	
	var notes_holder = $VSplitContainer/HBoxContainer2/MusicNotes
	music_note_list += (notes_holder.get_children())
	music_note_list[music_note_idx].set("custom_colors/font_color", Color(0,1,0))
	$VSplitContainer/HBoxContainer2/MusicNotes/Keys.texture = load("res://assets/backgrounds/key_plain.png")
	#print(music_note_list)
	music_note_list.pop_front()
	#print(music_note_list)
	#$HSplitContainer/EnergyMeter.value = 100
	$HireArt.hide()
	$HireMusic.hide()
	$HireCode.hide()
	$Stage2Jump.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $VSplitContainer/GameProgress/Percent.value == 300:
		if games_made_counter == 0:
			$VSplitContainer/Status.text = "First game complete!!! \n Behold, Dwarven Dungeon!"
			$VSplitContainer/GameProgress/GameCompletion2.text = "Next Game: Progress Percent"
		elif games_made_counter == 1:
			main.update_money(5000)
		elif games_made_counter == 2:
			main.update_money(25000)
			$HireArt.show()
		elif games_made_counter == 3:
			main.update_money(40000)
			$HireMusic.show()
		elif games_made_counter == 4:
			main.update_money(65000)
			$HireCode.show()
		elif games_made_counter == 5:
			main.update_money(80000)
			$Stage2Jump.show()
			# TODO add a total games made counter
			# also change your title to published developer
			# TODO show copies sold, trigger a new visual setup? (show dd and play music)
			# add a buyable factory with stuff like textbooks and other stuff
		$VSplitContainer/GameProgress/Percent.value = 0
		art_progress.value = 0
		music_progress.value = 0
		code_progress.value = 0
		games_made_counter += 1
	if $VSplitContainer/HSplitContainer/EnergyMeter.value == 0:
		#$VSplitContainer/Status.text = "I really need a nap"
		tired = true
	else:
		tired = false
	


func _on_Timer_timeout():
	$VSplitContainer/HSplitContainer/EnergyMeter.value -= 1
	var _val = $VSplitContainer/HSplitContainer/EnergyMeter.value
	if $VSplitContainer/HSplitContainer/EnergyMeter.value == 0:
		if first_sleep_appear == false:
			first_sleep_appear = true
			$VSplitContainer/CoffeeSleepBox/Sleep.show()
			#$VSplitContainer/HBoxContainer/Eat.show()
			#$VSplitContainer/HBoxContainer/Socialize.show()
		#$VSplitContainer/HSplitContainer/EnergyMeter.get("custom_styles/fg").set_bg_color(Color(
		#	1.0 if val<50 else (2 - 2*(val/100)),
		#	1.0 if val>50 else (2*(val/100)),
		#	0,1))
		# Assuming you have a reference to your EnergyMeter node
		#var progressbar = $VSplitContainer/HSplitContainer/EnergyMeter
		#print("Hello1")
		# Create a new ColorRect as the background
		#var background = ColorRect.new()
		#print("Hello2")
		#background.color = Color(0.2, 0.2, 0.2)  # Set the desired background color
		#print("Hello3")
		#progressbar.add_child(background)

		# Convert the ColorRect to a Texture
		#var texture = background.get_texture()
		#print("Hello4")
		# Set the Texture as the background of the ProgressBar
		#progressbar.background = texture
		#print("Hello5")
	if artist_hired == true:
		art_progress.value += .125
	if musician_hired == true:
		music_progress.value += .1
	if dev_hired == true:
		code_progress.value += .1
	game_progress.value = art_progress.value + music_progress.value + code_progress.value
	#var pf = get_node("../scenes/ProjectFactory")
	
	
	#RNG generate a bug
	#if rand_range(1, 100) > 90:
	#	# TODO generate a random location for the bug button
	#	pf.generateProject("Bug " + str(count))
	#	count += 1
	
		#music_note_list[music_note_idx].set("custom_colors/font_color", Color(1,0,0))

		
	#$scenes/ProjectFactory.generateProject("Testing " + str(count))

	#print($ProjectFactory.project_list)

func _input(event):
	if event is InputEventKey:
		if sleeping == true:
			return
		if tired == true:
			return
		if event.pressed and event.unicode != 0:
			var typed_character = char(event.unicode)
			if typed_character == music_note_list[music_note_idx].text:
				$VSplitContainer/HBoxContainer2/MusicNotes/Keys.texture = load("res://assets/backgrounds/key_green_" + str(music_note_idx) + ".png")
				asm.play("res://assets/sounds/" + str(sound_idx) + ".mp3")
				music_progress.value += music_skill
				game_progress.value = art_progress.value + music_progress.value + code_progress.value
				if $VSplitContainer/GameProgress/Percent.value > 15:
					if !$VSplitContainer/H/v1.visible:
						$VSplitContainer/H/v1.show()
						$VSplitContainer/HBoxContainer2/TextureRect.show()
						$VSplitContainer/GameProgress/GameCompletion2.show()
						$VSplitContainer/GameProgress/Percent.show()
				music_skill += (0.0175 * (games_made_counter +1))
				music_note_list[music_note_idx].set("custom_colors/font_color", Color(1,1,1))
				music_note_idx = (music_note_idx + 1) % 7
				#MyImage.texture = load("res://Graphics/image.png")
				$VSplitContainer/HBoxContainer2/MusicNotes/Keys.texture = load("res://assets/backgrounds/key_yellow_" + str(music_note_idx) + ".png") 
				sound_idx = (sound_idx + 1) % 56
				music_note_list[music_note_idx].set("custom_colors/font_color", Color(0,1,0))

var coffee_sounds = [
"clink.mp3",
"clinck2sip_swallow2.mp3",
"sip_swallow.mp3",
"ahhh.mp3",
"sip_ahhh.mp3"
]

func _on_Drink_Coffee_pressed():
	# Play coffee drinking sound 40% of the time
	if rand_range(0,10) > 6:
		var which = rand_range(0, len(coffee_sounds))
		var coffee_noise = coffee_sounds[which]
		#asm.play("res://assets/sounds/" + coffee_noise)
		

	var coffee_text = coffee_phrases[rand_range(0,len(coffee_phrases))]
	#Coffee with good friends is one of life's true delights
	$VSplitContainer/Status.text = coffee_text
	#$VSplitContainer/Status.text = "Sipping on that lovely coffee"
	# generate a list of coffee comments and rng them
	tired = false
	if sleeping == true:
		return

	main.update_money(-5)
	$VSplitContainer/HSplitContainer/EnergyMeter.value = 100 - coffee_penalty
	if coffee_penalty == 0:
		coffee_penalty += 6
	else:
		coffee_penalty += 3
	$VSplitContainer/HSplitContainer/EnergyMeter.show()
	$VSplitContainer/HSplitContainer/Label.show()
	$Timer.start()
	if computer_boot_flag == 0:
		computer_boot_flag = 1
		$VSplitContainer/BootComputer.show()
	if removed == true:
		print('adding the child back')
		#print(removable)
		#$VSplitContainer/HSplitContainer2.add_child(removable)
		#$VSplitContainer/HSplitContainer2/HelloWorld.show()
		
	#hopefully calls the coffee animation.  Unhide the sprite. call the animation. hide the sprite
	$CoffeeMug/AnimationPlayer.play("CoffeeUp")
	$OpenBook/AnimationPlayer.play("BookUp")
	

func _on_WalkDesk_pressed():
	$VSplitContainer/Status.text = "Time to get ready to play some video games"
	if sleeping == true:
		return
	$VSplitContainer/WalkDesk.hide()
	$VSplitContainer/CoffeeSleepBox/DrinkCoffee.show()


func _on_Boot_Computer_pressed():
	main.announce("Today, you will MAKE the game, others will play")
	if sleeping == true:
		main.announce("zzzzz....")
		return
	$VSplitContainer/BootComputer.hide()
	# TODO play animation of bootup
	# text fade in
	$VSplitContainer/HBoxContainer2/Coding/Code.show()
	
	return

	$VSplitContainer/H.show()
	#$VSplitContainer/HBoxContainer2/Art.show()
	#$VSplitContainer/HBoxContainer2/Music.show()

	#$VSplitContainer/HSplitContainer2/Label.show()
	#$VSplitContainer/HSplitContainer2/HelloWorld.show()
	
	$VSplitContainer/HBoxContainer2/MusicNotes.show()
	$VSplitContainer/HBoxContainer2/TextureRect.show()
	# TODO this is where I lay out the rest of the primary round 1 properties and things to track
	# trigger game progress and bugs as well


func _on_HelloWorld_gui_input(_event):
	if sleeping == true:
		return
	if tired == true:
		if rand_range(1, 100) > 70:
			return
	if $VSplitContainer/HSplitContainer/EnergyMeter.value == 0:
		removed = true
		$VSplitContainer/HSplitContainer2/HelloWorld.get_parent().remove_child($VSplitContainer/HSplitContainer2/HelloWorld)
		
		#$VSplitContainer/HSplitContainer2/HelloWorld.set_process_input(false)
		#$VSplitContainer/HSplitContainer2/HelloWorld.max_length = len($VSplitContainer/HSplitContainer2/HelloWorld.text)
		#print($VSplitContainer/HSplitContainer2/HelloWorld.max_length)
		#$VSplitContainer/HSplitContainer2/HelloWorld.max_length -= 1



func _on_SleepButton_pressed():
	main.announce("zzzz...")
	$VSplitContainer/Status.text = "zzzzzz..."
	sleeping = true
	coffee_penalty = 0
	$SleepTimer.start()


func _on_SleepTimer_timeout():
	$VSplitContainer/Status.text = "I'm up, I'm up"
	sleeping = false
	tired = false
	$VSplitContainer/HSplitContainer/EnergyMeter.value = 100
	

func _on_Study_pressed():
	$VSplitContainer/Status.text = "Ugh, this is brutal"
	if tired == true:
		main.announce("Yaaaawwwwwnnnn")
		if rand_range(1, 100) > 10:
			programming_skill -= 0.005
			return
	$VSplitContainer/HSplitContainer/EnergyMeter.value -= rand_range(0,5)
	programming_skill += 0.001

var code_counter = 0
func _on_Code_pressed():
	if sleeping == true:
		main.announce("zzzz...")
		return
	if code_counter < 10:
		if code_counter == 0:
			$VSplitContainer/H/v3.show()
		code_counter += 1
	if code_counter == 10:
		code_counter += 1
		$VSplitContainer/HBoxContainer2/Coding/Study.show()
	
	$VSplitContainer/Status.text = "Clickety clack"
	if tired == true:
		if rand_range(1, 100) > 5:
			pf.generateProject("Bug " + str(count))
			count += 1
			return
	if (rand_range(0,1) * len(pf.project_list)) > 20:
		print("BUG! Nothing got done")
		return

	code_progress.value += programming_skill
	if code_progress.value > 5:
		if !$VSplitContainer/H/v2.visible:
			$VSplitContainer/H/v2.show()
			$VSplitContainer/HBoxContainer2/MusicNotes.show()
			$VSplitContainer/HBoxContainer2/MusicNotes/Keys.texture = load("res://assets/backgrounds/key_yellow_" + str(music_note_idx) + ".png")
	game_progress.value = art_progress.value + music_progress.value + code_progress.value
	if $VSplitContainer/GameProgress/Percent.value > 15:
		if !$VSplitContainer/H/v1.visible:
			$VSplitContainer/H/v1.show()
			$VSplitContainer/HBoxContainer2/TextureRect.show()
			$VSplitContainer/GameProgress/GameCompletion2.show()
			$VSplitContainer/GameProgress/Percent.show()

	programming_skill += (0.0001 * (games_made_counter+1))
	if rand_range(1, 100) < 5 + code_progress.value*.5:
		pf.generateProject("Bug " + str(count))
		count += 1




var start_flow = 0
func _on_StartFlow_pressed():
	if start_flow == 0:
		$VSplitContainer/StartFlow.text = "Brew Coffee"
		# effect (sound and animation for coffee)
	elif start_flow == 1:
		#sound of coffee brew
		asm.play("res://assets/sounds/short_percolate.mp3")
		$VSplitContainer/StartFlow.text = "Walk over to desk"

	elif start_flow == 2:
		$VSplitContainer/StartFlow.text = "Boot Computer"

		# set a timer to sleep here so you have to wait

	elif start_flow == 3:
		main.announce("Booting...")
		main.announce("Boot complete")
		$VSplitContainer/login_itch.show()
		$VSplitContainer/StartFlow.text = "Login to itch.io"
		
	elif start_flow == 4:
		main.player_name = $VSplitContainer/login_itch/LineEdit.text
		main.announce("Username: ctrl-alt-delicious")
		main.announce("Password: xxxxxxxxxxxxxxxxx")
		# happy effect goes here
		$VSplitContainer/Status.text = "Title: Player"
		$VSplitContainer/StartFlow.text = "Play Game"
		
	elif start_flow == 5:
		#$VSplitContainer/StartFlow.text = ""
		main.announce("Loading...")
		main.announce("Error!, Couldn't load game")
		
	elif start_flow == 6:
		#$VSplitContainer/StartFlow.text = ""
		main.announce("Loading...")
		main.announce("Error!, Couldn't load game")
		
	elif start_flow == 7:
		#$VSplitContainer/StartFlow.text = ""
		main.announce("Loading...")
		main.announce("Error!, Couldn't load game")
		main.announce("Error!, Couldn't load")
		main.announce("Error!, Couldn't lo")
		main.announce("Error!")
		$VSplitContainer/StartFlow.text = "Game"

	elif start_flow == 8:
		$VSplitContainer/StartFlow.text = "Make Game"
		main.announce("Uhhh...")
		main.announce("What !?!?!")
		main.announce("$#*^$#@@")

	elif start_flow == 9:
		main.announce("Fine.")
		$VSplitContainer/Status.text = "Title: Coerced Developer"
		$VSplitContainer/StartFlow.text = "Install Godot"

	elif start_flow == 10:
		main.announce("Installing...")
		# beach ball animation or spinning godot logo
		main.announce("Install complete.")
		$VSplitContainer/StartFlow.hide()
		$VSplitContainer/CoffeeSleepBox/DrinkCoffee.show()
		
	start_flow += 1


func _on_HireArt_pressed():
	if main.money > 25000:
		main.update_money(-25000)
		artist_hired = true
		$HireArt.hide()

func _on_HireMusic_pressed():
	if main.money > 30000:
		main.update_money(-30000)
		musician_hired = true
		$HireMusic.hide()

func _on_HireCode_pressed():
	if main.money > 40000:
		main.update_money(-40000)
		dev_hired = true
		$HireCode.hide()


func _on_Stage2Jump_pressed():
	main.moveToStage2()

