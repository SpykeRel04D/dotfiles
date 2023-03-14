#!/usr/bin/env zsh

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

SAYINGS=(
	"May the Force be with you.\n  -- Star Wars, 1977"
	"There's no place like home.\n  -- The Wizard of Oz, 1939"
	"Carpe diem. Seize the day, boys. Make your lives extraordinary.\n  -- Dead Poets Society, 1989"
	"Elementary, my dear Watson.\n  -- The Adventures of Sherlock Holmes, 1939"
	"It's alive! It's alive!\n  -- Frankenstein, 1931"
    "My mama always said life was like a box of chocolates. You never know what you're gonna get\n  -- Forrest Gump, 1994"
	"Keep your friends close, but your enemies closer.\n  -- The Godfather Part II, 1974"
	"I am your father.\n  -- Star Wars Episode V: The Empire Strikes Back, 1980"
	"Roads? Where we're going we don't need roads.\n  -- Back to the Future, 1985"
	"They may take our lives, but they'll never take our freedom!\n  -- Braveheart, 1995"
	"To infinity and beyond!\n  -- Toy Story, 1995"
)

# Print a randomly-chosen message:
echo $SAYINGS[$(($RANDOM % ${#SAYINGS} + 1))]

} >&2