
extends Node

# Army Size Script for Dynasty Geopolitical Game
# This script manages the army size calculations and related functionalities

# Constants
const BASE_ARMY_SIZE = 1000
const MAX_ARMY_SIZE = 1000000
const MIN_ARMY_SIZE = 100

# Variables
var current_army_size: int = 0
var population: int = 0
var economy_strength: float = 1.0
var technology_level: int = 1
var military_budget: float = 0.0
var training_quality: float = 1.0
var morale: float = 1.0
var terrain_factor: float = 1.0
var climate_factor: float = 1.0
var war_exhaustion: float = 0.0

# Signals
signal army_size_changed(new_size)
signal max_army_size_reached
signal min_army_size_reached

# Called when the node enters the scene tree for the first time
func _ready():
	initialize_army_size()

# Initialize the army size based on starting conditions
func initialize_army_size():
	current_army_size = calculate_initial_army_size()
	emit_signal("army_size_changed", current_army_size)

# Calculate the initial army size based on various factors
func calculate_initial_army_size() -> int:
	var initial_size = BASE_ARMY_SIZE
	initial_size += int(population * 0.01)  # 1% of population
	initial_size = int(initial_size * economy_strength)
	initial_size = int(initial_size * (1 + (technology_level * 0.05)))  # 5% increase per tech level
	return clamp(initial_size, MIN_ARMY_SIZE, MAX_ARMY_SIZE)

# Update the army size based on various factors
func update_army_size():
	var new_size = current_army_size
	new_size = int(new_size * (1 + (military_budget * 0.1)))  # 10% increase per budget point
	new_size = int(new_size * training_quality)
	new_size = int(new_size * morale)
	new_size = int(new_size * terrain_factor)
	new_size = int(new_size * climate_factor)
	new_size = int(new_size * (1 - war_exhaustion))
	
	set_army_size(new_size)

# Set the army size and emit signals
func set_army_size(new_size: int):
	var clamped_size = clamp(new_size, MIN_ARMY_SIZE, MAX_ARMY_SIZE)
	
	if clamped_size != current_army_size:
		current_army_size = clamped_size
		emit_signal("army_size_changed", current_army_size)
		
		if current_army_size == MAX_ARMY_SIZE:
			emit_signal("max_army_size_reached")
		elif current_army_size == MIN_ARMY_SIZE:
			emit_signal("min_army_size_reached")

# Increase the army size by a given amount
func increase_army_size(amount: int):
	set_army_size(current_army_size + amount)

# Decrease the army size by a given amount
func decrease_army_size(amount: int):
	set_army_size(current_army_size - amount)

# Set the population and update army size
func set_population(new_population: int):
	population = max(0, new_population)
	update_army_size()

# Set the economy strength and update army size
func set_economy_strength(new_strength: float):
	economy_strength = clamp(new_strength, 0.1, 10.0)
	update_army_size()

# Set the technology level and update army size
func set_technology_level(new_level: int):
	technology_level = max(1, new_level)
	update_army_size()

# Set the military budget and update army size
func set_military_budget(new_budget: float):
	military_budget = clamp(new_budget, 0.0, 1.0)
	update_army_size()

# Set the training quality and update army size
func set_training_quality(new_quality: float):
	training_quality = clamp(new_quality, 0.5, 2.0)
	update_army_size()

# Set the morale and update army size
func set_morale(new_morale: float):
	morale = clamp(new_morale, 0.5, 1.5)
	update_army_size()

# Set the terrain factor and update army size
func set_terrain_factor(new_factor: float):
	terrain_factor = clamp(new_factor, 0.8, 1.2)
	update_army_size()

# Set the climate factor and update army size
func set_climate_factor(new_factor: float):
	climate_factor = clamp(new_factor, 0.9, 1.1)
	update_army_size()

# Set the war exhaustion and update army size
func set_war_exhaustion(new_exhaustion: float):
	war_exhaustion = clamp(new_exhaustion, 0.0, 1.0)
	update_army_size()

# Calculate the maximum potential army size based on current factors
func calculate_max_potential_army_size() -> int:
	var max_potential = BASE_ARMY_SIZE
	max_potential += int(population * 0.05)  # 5% of population
	max_potential = int(max_potential * economy_strength * 1.5)
	max_potential = int(max_potential * (1 + (technology_level * 0.1)))  # 10% increase per tech level
	max_potential = int(max_potential * (1 + military_budget))
	max_potential = int(max_potential * training_quality * 1.2)
	max_potential = int(max_potential * morale * 1.1)
	return min(max_potential, MAX_ARMY_SIZE)

# Calculate the army maintenance cost
func calculate_army_maintenance_cost() -> float:
	var base_cost = current_army_size * 0.1  # Base cost per soldier
	var tech_modifier = 1 + (technology_level * 0.02)  # 2% increase per tech level
	var quality_modifier = training_quality * 1.5
	return base_cost * tech_modifier * quality_modifier

# Calculate the army's combat effectiveness
func calculate_combat_effectiveness() -> float:
	var effectiveness = 1.0
	effectiveness *= training_quality
	effectiveness *= morale
	effectiveness *= (1 + (technology_level * 0.05))  # 5% increase per tech level
	effectiveness *= (1 - war_exhaustion)
	effectiveness *= terrain_factor
	effectiveness *= climate_factor
	return effectiveness

# Simulate a battle and return casualties
func simulate_battle(enemy_army_size: int, enemy_combat_effectiveness: float) -> Dictionary:
	var our_strength = current_army_size * calculate_combat_effectiveness()
	var enemy_strength = enemy_army_size * enemy_combat_effectiveness
	
	var total_strength = our_strength + enemy_strength
	var our_casualty_rate = enemy_strength / total_strength
	var enemy_casualty_rate = our_strength / total_strength
	
	var our_casualties = int(current_army_size * our_casualty_rate * randf_range(0.8, 1.2))
	var enemy_casualties = int(enemy_army_size * enemy_casualty_rate * randf_range(0.8, 1.2))
	
	decrease_army_size(our_casualties)
	
	return {
		"our_casualties": our_casualties,
		"enemy_casualties": enemy_casualties
	}

# Train troops to improve quality
func train_troops(duration: float, intensity: float):
	var quality_increase = duration * intensity * 0.01  # 1% increase per unit of duration * intensity
	set_training_quality(training_quality + quality_increase)

# Boost morale through various actions
func boost_morale(amount: float):
	set_morale(morale + amount)

# Handle the effects of a long war
func apply_war_exhaustion(duration: float):
	var exhaustion_increase = duration * 0.01  # 1% increase per unit of duration
	set_war_exhaustion(war_exhaustion + exhaustion_increase)

# Recover from war exhaustion during peacetime
func recover_from_war_exhaustion(duration: float):
	var exhaustion_decrease = duration * 0.02  # 2% decrease per unit of duration
	set_war_exhaustion(max(0, war_exhaustion - exhaustion_decrease))

# Apply the effects of a new technology
func apply_new_technology():
	set_technology_level(technology_level + 1)
	var quality_boost = 0.05  # 5% boost to training quality
	set_training_quality(training_quality + quality_boost)

# Handle population growth and its effect on army size
func handle_population_growth(growth_rate: float):
	var new_population = int(population * (1 + growth_rate))
	set_population(new_population)

# Handle economic changes and their effect on army size
func handle_economic_change(change: float):
	set_economy_strength(economy_strength + change)

# Adjust army size based on available resources
func balance_army_size_with_resources(available_resources: float):
	var ideal_size = int(available_resources / calculate_army_maintenance_cost() * current_army_size)
	set_army_size(ideal_size)

# Generate a detailed report of the army's current status
func generate_army_report() -> String:
	var report = "Army Status Report\n"
	report += "-------------------\n"
	report += "Current Army Size: %d\n" % current_army_size
	report += "Maximum Potential Army Size: %d\n" % calculate_max_potential_army_size()
	report += "Population: %d\n" % population
	report += "Economy Strength: %.2f\n" % economy_strength
	report += "Technology Level: %d\n" % technology_level
	report += "Military Budget: %.2f\n" % military_budget
	report += "Training Quality: %.2f\n" % training_quality
	report += "Morale: %.2f\n" % morale
	report += "Terrain Factor: %.2f\n" % terrain_factor
	report += "Climate Factor: %.2f\n" % climate_factor
	report += "War Exhaustion: %.2f\n" % war_exhaustion
	report += "Combat Effectiveness: %.2f\n" % calculate_combat_effectiveness()
	report += "Maintenance Cost: %.2f\n" % calculate_army_maintenance_cost()
	return report

# Save the current army state
func save_army_state() -> Dictionary:
	return {
		"current_army_size": current_army_size,
		"population": population,
		"economy_strength": economy_strength,
		"technology_level": technology_level,
		"military_budget": military_budget,
		"training_quality": training_quality,
		"morale": morale,
		"terrain_factor": terrain_factor,
		"climate_factor": climate_factor,
		"war_exhaustion": war_exhaustion
	}

# Load a saved army state
func load_army_state(state: Dictionary):
	current_army_size = state.get("current_army_size", BASE_ARMY_SIZE)
	population = state.get("population", 0)
	economy_strength = state.get("economy_strength", 1.0)
	technology_level = state.get("technology_level", 1)
	military_budget = state.get("military_budget", 0.0)
	training_quality = state.get("training_quality", 1.0)
	morale = state.get("morale", 1.0)
	terrain_factor = state.get("terrain_factor", 1.0)
	climate_factor = state.get("climate_factor", 1.0)
	war_exhaustion = state.get("war_exhaustion", 0.0)
	
	emit_signal("army_size_changed", current_army_size)
