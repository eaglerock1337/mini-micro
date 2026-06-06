# tmsim design notes

## game overview

This game is a survival strategy RPG game for the Mini Micro designed to be extremely difficult to win, but losing is part of the fun. Your character can gain experience from games, win or lose, which helps level up skills and stats. There are multiple difficulty modes, as well as an in-game computer with an immersive Mini Micro system that includes a snarky AI bot that can help you get home.

You play as the stereotypical 80s time traveling teenager trying to get back home using a time machine that is built by an eccentric scientist much in the style of Rick Sanchez from Rick and Morty. It's a futuristic device complete with all tools necessary to get around undetected. It's very much a prototype system that breaks a lot. which isn't a problem for its owner, but is a big problem for a teenager who accidentally time travels back in time and needs to figure out how to get home.

The game starts with an opening dialogue where you come across the running device, and open its cockpit door out of curiosity. You're greeted by all this futuristic stuff, and get in to the comfy cockpit chair to look around. You shut the cockpit door and beeping sounds draw your attention to the screen. You see screen's interface, which runs a systems check and has a big green execute button that you point and click with the mouse. This executes a time travel sequence which will have a bunch of fancy graphics.

The computer is running an operating system called TDOS, the Temporal Displacement Operating System. All of this is running on an alternate reality computer that is an 8-bit Z80 CPU based on the real-life RC2014 hobby computer, but works like the Mini Micro, the neo-retro virtual computer. TDOS runs on one of its two disks, while the other contains D.O.C. (Displacement Operations Companion), an LLM AI assistant. You talk to the assistant using commands similar to the old-school classic Super Star Trek game from the 1970s. The LLM is fully trained on all aspects of time travel (including the movies its based on, so it loves to throw references in from the classic 80s time traveling movies).

D.O.C. was trained by an eccentric scientist to helping survive when time traveling, and it is trained off of his time traveling notes, so it has taken on a snarky tone with a deprecating sense of humor with a hint of superiority and elitism. Part of the AI capabilities is to scan the cockpit for a health assessment, where the AI realizes you aren't the owner. After an automatic cooldown procedure post-time travel (where a lot of things can break), D.O.C. gives a sensor report describing the date, time, and surroundings, followed by a full systems report. This is where you get a sense of what you just did and in what kind of condition the device is really in. After the system report is a health report where you get a report on your own health. The health scan on the cockpit reveals you are not the owner, so the LLM kicks in with a nice tirade on the kid and the trouble they just got themselves into:

"Great job, idiot. Great. Job. What a mess you're in. Either you've mastered string theory and thought it was a great idea to steal a time machine clearly built by a lunatic that shouldn't be trusted with technology, or you're somebody dumb enough to just waddle on in here, sit all down comfy-like inside of a  big orb thing out in the middle of a war zone? But that's who you are, right? Just some dumb teenager. You appear to be around 17, so let me guess, you have a band, right? You're the cool one with the guitar? Seriously, Keanu, Seriously. It's DONE, Isn't the time-travelling trope about 35 years too late? You're doing it on an 8-bit computer that doesn't really exist, though, so that probably tracks."
  
You basically get a whole rant from D.O.C. that turns into a tutorial about the game, after which you are entered into the game world. The tutorial helps you understand the time machine, how to operate it, and how to play the game itself. From that point you are dropped into the D.O.C. chat interface where you can start by typing commands to D.O.C. and play the game. The game features multiple views (Mini Micro screen, Inside the TM, Outside the TM, Main Menu), multiple profiles/savefiles with different RPG stats per character. The goal is to get back to present day, which will require maintaining the time machine, disguising it and keeping it out of sight, gathering resources, disguising yourself, and making sure to eat and drink. Time travel requires a LOT of energy, more engergy the farther you are travelling in time, so you probably need to take several trips to make it back.

Time passes as you take actions, and actions can have consequences. Survival is important and there are plenty of things in the wild that can hurt you, but civilization is even more dangerous. The main threat in the game is Aggro, which is easy to go up and hard to go down. The more people are alerted to your presence, the more dangerous it is. Being spotted and standing out (inappropriate attire, behavior, etc.) raises your aggro and can potentially cause you to be captured. Someone spotting the time machine is worse, as it will scare people in general. All of these interactions and events have skill rolls against your stats, so your chances improve as you keep playing. There are also difficulty modes that make the game harder or easier (more energy to time travel, starting farther back in time, more aggro, more damaged parts, higher chance of part failure, etc.), and the whole game is scored. Higher difficulties give better score multipliers and there's a hall of fame to track the best characters. Harder difficulties will have more parts to maintain, as well, as the computer has a possibility of failing. You'll need to replace IC's and potentially desolder and solder parts in the hardest levels.

The primary game driver is taking as much time as you can to maintain the time machine and build up energy to get home, but every time travel has a sunk cost in energy you want to try to stretch over as many years as possible. The trouble is Aggro, which can force you to time travel to lower the heat. Hover propulsion (when it works) can help reduce aggro by getting away from an area on alert, but that only works so much and costs energy as well. Time travel lowers your aggro, but locals can have memory of your prior actions, so time travelling only a few years in the future will cause people to remember similar interactions and you'll regain Aggro very quickly, so the game is all about balance and judgment calls that can make the difference between success and failure.

I'm hoping to build in many actions that can cause you to make decisions with their own skill rolls (that I can build up over time) to make every game feel like its own adventure with many interactions and ways to mess up and get lucky. Each game should have a short epilogue that should feel unique and want you to keep playing and try again.

## time machine

It's a time machine about the size of a smart car and is equipped with everything a time traveler needs to not get caught. This includes an airtight cockpit with life support, threat sensors, water collector, food generator, invisibility shield, and hover propulsion. The time machine itself has time circuits and the flux capacitor, of course. All of this requires a lot of power, though, so the machine is equipped with 3 ways of fueling it: a wood generator that will provide a trickle of energy in quiet mode when left alone, but can be actively tended to burn a large amount of wood (through active gameplay), a Mr. Fusion, capable of generating a lot of power from trash when available, and a mysterious Resonance Coil, capable of harnessing static electricity in the air, but make a lot of noise and electric arcs, so it's only usable in safe areas that won't draw attention. 

All of this is controlled by a control panel on the left side of the cockpit that allows for the management of all of these components through a power distribution unit, including a computer, which will be an alternate reality 1980's Z80 CPU based Mini Micro system. It will be in soldered modules, much like the RC2014 hobby computer. This includes a monitor and keyboard at the front of the cockpit that can be used to control the computer. It'll run just like the Mini Micro, off of disks and using the Mini Micro. The disk in the system contains TDOS, the Temporal Displacement Operating System. This system, through the control panel, has full visibility into everything going on. The second disk contains D.O.C. the snarky AI assistant, which is designed to help you out.

Parts have wear and tear. Tear is damage that can be repaired with a sufficient engineering skill level, while wear cannot be repaired. Wear and tear multiply to the part's overall condition. Parts have a potential of breaking both before and after time travel which increases based on condition and difficulty level. As part condition degrades, the status of the part goes from OK, to Info-level issues, then Warnings, finally, Faults. Some parts are required for time travel, others are not, but losing auxillary parts (such as the water collector and food generator) will require you to take riskier actions to survive.

Parts in lower conditions can make things harder but still allow the game to continue. For example, a damaged PC can make D.O.C. unusable (not enough RAM or performance, for example) which requires you to go without threat analysis and help. It will also disable GUI mode, making the interface harder to use and incentivizing people to get comfortable with the TUI. This will only happen in difficulties beyond Easy when the full part list (CPU, RAM, backplane, etc.) are included.

If a critical part fails beyond repair, There will be some endings where you can give up. Maybe you'll be able to survive by assimilating with the locals and living the rest of your days in another time period, maybe you'll get burned at the stake, but at any point in time you can give up to avoid hopeless gameplay.

## the player

The player has stats and a character level. Character levels allow for skill improvements (TBD), while main stats handle stat rolls:

- Intelligence - helps gaining wisdom and dealing with situations
- Wisdom - gained by experience, helps with all tasks
- Engineering - helps with working with the time machine and handling repairs
- Dexterity - helps with laborious activies, evasion, and other physical challenges
- Disguise - helps with blending in, reducing aggro, and avoiding people, or smoothing over encounters
- Luck - helps with everything

A freshly rolled character is going to stumble a lot, but gain valuable experience from each gameplay that slowly increases stats and level, which will make life easier. Leveling will allow for building a skill tree which helps in other ways, and can help the player customize their character and make parts of the game easier.

## design plan

Then plan for building the game is as follows:

### phase 1 - foundations

- build out core data structures for the time machine and the player
- get TDOS working with its TUI and the basic time machine mechanics working
- test time travel and part breakage/statuses with debug TDOS commands
- build out different views with basic game activities
- build out main menu and get game saves working preserving active games
- build out player stats, exp, and level

### phase 2 - core gameplay

- create game intro
- create game difficulties and start tuning game mechanics
- start building out some core events
- build out scoring system
- build out a basic game ending system that gives the epilogue
- game should feel like an MVP at this point

### later phases

The following are going to be things built out later in individual phases in no particular order:

- skill tree system
- full game event system
- TDOS GUI mode
- game graphics and sounds, visual polish

### path to 1.0

The following is the last part of game development once we are reaching the 1.0 release:

- tuning of game difficulty with all core gameplay included
- debugging, polish, and other last minute improvements
- automated packaging up of the game for release to others
- possibly splitting tmsim into its own repo
- release of 1.0 and sharing game
