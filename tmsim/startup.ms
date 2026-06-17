// Time Machine Simulator - Bootstrap
// Sets up import paths, then launches the game.
// Works as both /usr (autostart) and /usr2 (development).

_diskRoot = "/usr2"
_gameFile = "tmsim.ms"
if not file.exists(_diskRoot + _gameFile) then _diskRoot = "/usr"

_libPath = _diskRoot + "/lib"
if not env.hasIndex("importPaths") then env.importPaths = ["/sys/lib", "/usr/lib"]
if env.importPaths.indexOf(_libPath) == null then
	env.importPaths.push _libPath
end if

load file.child(_diskRoot, _gameFile)
run
