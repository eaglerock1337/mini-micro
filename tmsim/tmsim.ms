// tmsim.ms - the time machine simulator for the Mini Micro

// import global singleton objects
import "date"    // date calculator
import "game"    // main menu
import "player"  // player's character
import "sim"     // simulator loop
import "tdos"    // computer os loop
import "tm"      // time machine

// main routine
version = "0.0.1"
debug = true
game.init
date.test
game.run
