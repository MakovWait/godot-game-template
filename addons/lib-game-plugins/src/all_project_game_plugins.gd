class_name AllProjectGamePlugins
extends GamePluginSource


func add_to(plugins: InstalledGamePlugins) -> void:
	for resource in ResourceLib.load_all():
		if resource is GamePlugin:
			resource.add_to(plugins)
