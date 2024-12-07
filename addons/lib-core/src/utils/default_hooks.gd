static func use_stopwatch(parent: Node) -> Stopwatch:
	var stopwatch := Stopwatch.new()
	parent.add_child(stopwatch)
	return stopwatch
