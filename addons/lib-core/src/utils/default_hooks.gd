static func use_stopwatch(parent: Node) -> Stopwatch:
	var stopwatch := Stopwatch.new()
	parent.add_child(stopwatch)
	return stopwatch


static func use_timer(node: Node) -> Timer:
	var timer := Timer.new()
	node.add_child(timer)
	return timer


static func use_tick_timer(node: Node) -> TickTimer:
	var timer := TickTimer.new()
	node.add_child(timer)
	return timer
