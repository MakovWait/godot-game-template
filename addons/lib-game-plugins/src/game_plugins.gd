extends Node


var _installed := InstalledGamePlugins.new() 


func install(plugins_to_install: Array[GamePluginSource]) -> void:
	await _installed.cleanup()
	for plugin in plugins_to_install:
		await plugin.add_to(_installed)
	await _installed.finish()
	await _installed.validate()
