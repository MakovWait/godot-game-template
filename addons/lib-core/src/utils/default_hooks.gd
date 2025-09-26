static func use_stopwatch(parent: Node) -> Stopwatch:
	var stopwatch := Stopwatch.new()
	parent.add_child(stopwatch)
	stopwatch.owner = parent
	return stopwatch


static func use_timer(node: Node) -> Timer:
	var timer := Timer.new()
	node.add_child(timer)
	timer.owner = node
	return timer


static func use_oneshot_timer(node: Node) -> Timer:
	var timer := Timer.new()
	timer.one_shot = true
	node.add_child(timer)
	timer.owner = node
	return timer


static func use_tick_timer(node: Node) -> TickTimer:
	var timer := TickTimer.new()
	node.add_child(timer)
	timer.owner = node
	return timer
