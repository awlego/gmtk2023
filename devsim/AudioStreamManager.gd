extends Node

class_name AudioStreamManager

var num_players = 8
var bus = "master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.
var p = AudioStreamPlayer.new()

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		#var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", self, "_on_stream_finished", [p])
		p.bus = bus


func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_path):
	queue.append(sound_path)


func _process(_delta):
	if !p.is_playing():
		#print("we are not playing so maybe play")
		# Play a queued sound if any players are available.
		if not queue.empty() and not available.empty():
			available[0].stream = load(queue.pop_front())
			available[0].stream.set_loop(false)
			available[0].play()
			available.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
