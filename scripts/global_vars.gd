extends Node

var level: int = 1
var just_died: bool = false

# Numeric modifier IDs to preserve them after level resets
var modifiers = []

# Raw things the game script takes in for modifiers
var ball_size: float = 1
var raining_squares: bool = false
var speed: float = 1
var bouncy_ball: bool = false
var laser_attack: bool = false
