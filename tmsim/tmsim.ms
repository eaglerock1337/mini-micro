// tmsim.ms - the time machine simulator for the Mini Micro

// enable debug mode
debug = true

// import global singleton objects
import "game"    // main menu loop
import "player"  // player's character object
import "sim"     // simulator loop
import "tdos"    // computer os loop
import "tm"      // time machine object

// main routine
version = "0.0.1"
game.init
game.run
