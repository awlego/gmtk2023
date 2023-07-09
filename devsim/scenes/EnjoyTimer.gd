extends Timer
class_name EnjoyTimer

var enjoy_remaining = 1
var main
var earn_money_ratio = 0.1

func _init(enjoytime, mainsc):
	enjoy_remaining = enjoytime
	self.main = mainsc

func _ready():
	self.wait_time = 1.0
	self.one_shot = false
	connect("timeout", self, "enjoy")
	self.start()
	pass

func enjoy():
	var enjoytoday = int(0.1 * enjoy_remaining + 1)
	enjoy_remaining -= enjoytoday
	main.update_enjoy(enjoytoday)
	main.update_money(int(earn_money_ratio * enjoytoday))
	if enjoy_remaining <= 1:
		one_shot = true
