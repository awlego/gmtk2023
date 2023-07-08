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
var music_skill = 0.001
var main
var first_sleep_appear = false
var sleeping = true
var tired = true
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

# Called when the node enters the scene tree for the first time.
func _ready():
	$VSplitContainer/GameProgress/GameCompletion2.hide()
	$VSplitContainer/GameProgress/Percent.hide()
	$VSplitContainer/HSplitContainer/EnergyMeter.hide()
	$VSplitContainer/HSplitContainer/Label.hide()
	$VSplitContainer/DrinkCoffee.hide()
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
	$VSplitContainer/HBoxContainer2/Code.hide()
	$VSplitContainer/HBoxContainer/Sleep.hide()
	$VSplitContainer/HBoxContainer/Eat.hide()
	$VSplitContainer/HBoxContainer/Study.hide()
	$VSplitContainer/HBoxContainer/Socialize.hide()
	sleeping = false
	
	$VSplitContainer/Status.text = personal_status
	
	var notes_holder = $VSplitContainer/HBoxContainer2/MusicNotes
	music_note_list += (notes_holder.get_children())
	music_note_list[music_note_idx].set("custom_colors/font_color", Color(0,1,0))
	

	#$HSplitContainer/EnergyMeter.value = 100
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	$VSplitContainer/HSplitContainer/EnergyMeter.value -= 1
	var _val = $VSplitContainer/HSplitContainer/EnergyMeter.value
	if $VSplitContainer/HSplitContainer/EnergyMeter.value < 50:
		if first_sleep_appear == false:
			first_sleep_appear = true
			$VSplitContainer/HBoxContainer/Sleep.show()
			$VSplitContainer/HBoxContainer/Eat.show()
			$VSplitContainer/HBoxContainer/Study.show()
			$VSplitContainer/HBoxContainer/Socialize.show()
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
	#var pf = get_node("../scenes/ProjectFactory")
	
	
	#RNG generate a bug
	#if rand_range(1, 100) > 90:
	#	# TODO generate a random location for the bug button
	#	pf.generateProject("Bug " + str(count))
	#	count += 1
	
	if $VSplitContainer/HSplitContainer/EnergyMeter.value == 0:
		$VSplitContainer/Status.text = "I really need a nap"
		music_note_list[music_note_idx].set("custom_colors/font_color", Color(1,0,0))
		tired = true

		
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
				asm.play("res://assets/sounds/" + str(sound_idx) + ".mp3")
				$VSplitContainer/GameProgress/Percent.value += music_skill
				music_skill += 0.0001
				music_note_list[music_note_idx].set("custom_colors/font_color", Color(1,1,1))
				music_note_idx = (music_note_idx + 1) % 7
				sound_idx = (sound_idx + 1) % 56
				music_note_list[music_note_idx].set("custom_colors/font_color", Color(0,1,0))


func _on_Drink_Coffee_pressed():
	# Play coffee drinking sound
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
		coffee_penalty += 5
	else:
		coffee_penalty += 2
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

func _on_WalkDesk_pressed():
	$VSplitContainer/Status.text = "Time to get ready to play some video games"
	if sleeping == true:
		return
	$VSplitContainer/WalkDesk.hide()
	$VSplitContainer/DrinkCoffee.show()


func _on_Boot_Computer_pressed():
	$VSplitContainer/Status.text = "Today, you will MAKE the game, others will play"
	if sleeping == true:
		return
	$VSplitContainer/BootComputer.hide()
	# TODO play animation of bootup
	# text fade in
	$VSplitContainer/GameProgress/GameCompletion2.show()
	$VSplitContainer/GameProgress/Percent.show()
	$VSplitContainer/HBoxContainer2/Art.show()
	$VSplitContainer/HBoxContainer2/Music.show()
	$VSplitContainer/HBoxContainer2/Code.show()
	$VSplitContainer/HSplitContainer2/Label.show()
	#$VSplitContainer/HSplitContainer2/HelloWorld.show()
	$VSplitContainer/HBoxContainer2/MusicNotes.show()
	
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
	$VSplitContainer/Status.text = "zzzzzz..."
	sleeping = true
	tired = false
	coffee_penalty = 0
	$SleepTimer.start()


func _on_SleepTimer_timeout():
	$VSplitContainer/Status.text = "I'm up, I'm up"
	sleeping = false
	$VSplitContainer/HSplitContainer/EnergyMeter.value = 100
	


func _on_Study_pressed():
	$VSplitContainer/Status.text = "Ugh, this is brutal"
	if tired == true:
		if rand_range(1, 100) > 10:
			return
	$VSplitContainer/HSplitContainer/EnergyMeter.value -= rand_range(0,5)
	programming_skill += 0.001


func _on_Code_pressed():
	$VSplitContainer/Status.text = "Clickety clack"
	if tired == true:
		if rand_range(1, 100) > 5:
			pf.generateProject("Bug " + str(count))
			count += 1
			return
	if (rand_range(0,1) * len(pf.project_list)) > 20:
		print("BUG! Nothing got done")
		return
	$VSplitContainer/GameProgress/Percent.value += 1*programming_skill
	
	if $VSplitContainer/GameProgress/Percent.value == 100:
		$VSplitContainer/Status.text = "First game complete!!! \n Behold, Dwarven Dungeon!"
		$VSplitContainer/GameProgress/GameCompletion2.text = "Second Game: Progress Percent"
		$VSplitContainer/GameProgress/Percent.value = 0
		# TODO show copies sold, trigger a new visual setup? (show dd and play music)
		# add a buyable factory with stuff like textbooks and other stuff

	programming_skill += 0.0001
	if rand_range(1, 100) < 5 + $VSplitContainer/GameProgress/Percent.value*.5:
		pf.generateProject("Bug " + str(count))
		count += 1
