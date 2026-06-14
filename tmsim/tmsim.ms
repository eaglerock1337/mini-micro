// tmsim.ms - the time machine simulator for the Mini Micro

// enable debug mode
debug = true

// import global singleton objects
import "game"    // main menu loop
import "gruvbox" // gruvbox color theme hex codes
import "player"  // player's character object
import "screen"  // screen display layers
import "sim"     // simulator loop
import "tdos"    // computer os loop
import "tm"      // time machine object

// main routine
version = "0.0.1"
game.init
game.run
