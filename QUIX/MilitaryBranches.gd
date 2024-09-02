
extends Node

# Military Branches for Dynasty Geopolitical Game
# This script defines all military branches for the user's country

# Constants for branch types
const BRANCH_ARMY = "Army"
const BRANCH_NAVY = "Navy"
const BRANCH_AIR_FORCE = "Air Force"
const BRANCH_MARINE_CORPS = "Marine Corps"
const BRANCH_COAST_GUARD = "Coast Guard"
const BRANCH_SPACE_FORCE = "Space Force"
const BRANCH_CYBER_COMMAND = "Cyber Command"
const BRANCH_SPECIAL_OPERATIONS = "Special Operations"

# Class to represent a military branch
class MilitaryBranch:
	var name: String
	var personnel: int
	var budget: float
	var equipment: Dictionary
	var specializations: Array
	var readiness_level: float
	
	func _init(branch_name: String, initial_personnel: int, initial_budget: float):
		name = branch_name
		personnel = initial_personnel
		budget = initial_budget
		equipment = {}
		specializations = []
		readiness_level = 0.5  # Default readiness level (50%)
	
	func add_equipment(equipment_name: String, quantity: int):
		equipment[equipment_name] = quantity
	
	func add_specialization(specialization: String):
		specializations.append(specialization)
	
	func update_readiness(new_level: float):
		readiness_level = clamp(new_level, 0.0, 1.0)
	
	func increase_budget(amount: float):
		budget += amount
	
	func decrease_budget(amount: float):
		budget = max(0, budget - amount)
	
	func recruit_personnel(number: int):
		personnel += number
	
	func discharge_personnel(number: int):
		personnel = max(0, personnel - number)

# Main class for managing all military branches
class MilitaryForces:
	var branches: Dictionary
	var total_personnel: int
	var total_budget: float
	
	func _init():
		branches = {}
		total_personnel = 0
		total_budget = 0.0
	
	func create_branch(branch_name: String, initial_personnel: int, initial_budget: float):
		var new_branch = MilitaryBranch.new(branch_name, initial_personnel, initial_budget)
		branches[branch_name] = new_branch
		update_totals()
	
	func remove_branch(branch_name: String):
		if branches.has(branch_name):
			branches.erase(branch_name)
			update_totals()
	
	func get_branch(branch_name: String) -> MilitaryBranch:
		return branches.get(branch_name)
	
	func update_totals():
		total_personnel = 0
		total_budget = 0.0
		for branch in branches.values():
			total_personnel += branch.personnel
			total_budget += branch.budget
	
	func transfer_personnel(from_branch: String, to_branch: String, number: int):
		var source = get_branch(from_branch)
		var destination = get_branch(to_branch)
		if source and destination:
			source.discharge_personnel(number)
			destination.recruit_personnel(number)
			update_totals()
	
	func reallocate_budget(from_branch: String, to_branch: String, amount: float):
		var source = get_branch(from_branch)
		var destination = get_branch(to_branch)
		if source and destination:
			source.decrease_budget(amount)
			destination.increase_budget(amount)
			update_totals()
	
	func get_total_readiness() -> float:
		var total_readiness = 0.0
		for branch in branches.values():
			total_readiness += branch.readiness_level
		return total_readiness / branches.size() if branches.size() > 0 else 0.0

# Initialize the military forces for the user's country
var user_military = MilitaryForces.new()

func _ready():
	# Create and initialize all military branches
	initialize_army()
	initialize_navy()
	initialize_air_force()
	initialize_marine_corps()
	initialize_coast_guard()
	initialize_space_force()
	initialize_cyber_command()
	initialize_special_operations()

# Initialize Army
func initialize_army():
	user_military.create_branch(BRANCH_ARMY, 500000, 150000000000.0)
	var army = user_military.get_branch(BRANCH_ARMY)
	army.add_equipment("Main Battle Tank", 5000)
	army.add_equipment("Infantry Fighting Vehicle", 10000)
	army.add_equipment("Armored Personnel Carrier", 15000)
	army.add_equipment("Self-propelled Artillery", 2000)
	army.add_equipment("Towed Artillery", 3000)
	army.add_equipment("Multiple Rocket Launcher", 1000)
	army.add_specialization("Armored Warfare")
	army.add_specialization("Infantry Operations")
	army.add_specialization("Artillery Support")
	army.add_specialization("Air Defense")
	army.update_readiness(0.75)

# Initialize Navy
func initialize_navy():
	user_military.create_branch(BRANCH_NAVY, 350000, 180000000000.0)
	var navy = user_military.get_branch(BRANCH_NAVY)
	navy.add_equipment("Aircraft Carrier", 11)
	navy.add_equipment("Destroyer", 70)
	navy.add_equipment("Frigate", 50)
	navy.add_equipment("Submarine", 60)
	navy.add_equipment("Amphibious Assault Ship", 30)
	navy.add_equipment("Patrol Boat", 100)
	navy.add_specialization("Naval Aviation")
	navy.add_specialization("Submarine Warfare")
	navy.add_specialization("Surface Warfare")
	navy.add_specialization("Amphibious Operations")
	navy.update_readiness(0.8)

# Initialize Air Force
func initialize_air_force():
	user_military.create_branch(BRANCH_AIR_FORCE, 325000, 160000000000.0)
	var air_force = user_military.get_branch(BRANCH_AIR_FORCE)
	air_force.add_equipment("Fighter Aircraft", 1500)
	air_force.add_equipment("Bomber Aircraft", 200)
	air_force.add_equipment("Transport Aircraft", 300)
	air_force.add_equipment("Tanker Aircraft", 150)
	air_force.add_equipment("Reconnaissance Aircraft", 100)
	air_force.add_equipment("Unmanned Aerial Vehicle", 1000)
	air_force.add_specialization("Air Superiority")
	air_force.add_specialization("Strategic Bombing")
	air_force.add_specialization("Close Air Support")
	air_force.add_specialization("Aerial Refueling")
	air_force.update_readiness(0.85)

# Initialize Marine Corps
func initialize_marine_corps():
	user_military.create_branch(BRANCH_MARINE_CORPS, 180000, 50000000000.0)
	var marine_corps = user_military.get_branch(BRANCH_MARINE_CORPS)
	marine_corps.add_equipment("Amphibious Assault Vehicle", 1000)
	marine_corps.add_equipment("Light Armored Vehicle", 800)
	marine_corps.add_equipment("Main Battle Tank", 400)
	marine_corps.add_equipment("Artillery Piece", 600)
	marine_corps.add_equipment("Attack Helicopter", 200)
	marine_corps.add_equipment("Transport Helicopter", 300)
	marine_corps.add_specialization("Amphibious Warfare")
	marine_corps.add_specialization("Expeditionary Operations")
	marine_corps.add_specialization("Ship-to-Shore Movement")
	marine_corps.add_specialization("Rapid Deployment")
	marine_corps.update_readiness(0.9)

# Initialize Coast Guard
func initialize_coast_guard():
	user_military.create_branch(BRANCH_COAST_GUARD, 40000, 12000000000.0)
	var coast_guard = user_military.get_branch(BRANCH_COAST_GUARD)
	coast_guard.add_equipment("Patrol Boat", 200)
	coast_guard.add_equipment("Cutter", 100)
	coast_guard.add_equipment("Icebreaker", 10)
	coast_guard.add_equipment("Maritime Patrol Aircraft", 50)
	coast_guard.add_equipment("Helicopter", 100)
	coast_guard.add_specialization("Maritime Law Enforcement")
	coast_guard.add_specialization("Search and Rescue")
	coast_guard.add_specialization("Port Security")
	coast_guard.add_specialization("Environmental Protection")
	coast_guard.update_readiness(0.7)

# Initialize Space Force
func initialize_space_force():
	user_military.create_branch(BRANCH_SPACE_FORCE, 15000, 20000000000.0)
	var space_force = user_military.get_branch(BRANCH_SPACE_FORCE)
	space_force.add_equipment("Satellite", 100)
	space_force.add_equipment("Space Launch Vehicle", 20)
	space_force.add_equipment("Ground-based Radar", 50)
	space_force.add_equipment("Space Operations Center", 10)
	space_force.add_specialization("Space Surveillance")
	space_force.add_specialization("Satellite Operations")
	space_force.add_specialization("Missile Warning")
	space_force.add_specialization("Space Control")
	space_force.update_readiness(0.6)

# Initialize Cyber Command
func initialize_cyber_command():
	user_military.create_branch(BRANCH_CYBER_COMMAND, 10000, 10000000000.0)
	var cyber_command = user_military.get_branch(BRANCH_CYBER_COMMAND)
	cyber_command.add_equipment("Supercomputer", 50)
	cyber_command.add_equipment("Cyber Defense System", 100)
	cyber_command.add_equipment("Network Infrastructure", 1000)
	cyber_command.add_equipment("Cryptographic Device", 5000)
	cyber_command.add_specialization("Cyber Warfare")
	cyber_command.add_specialization("Information Operations")
	cyber_command.add_specialization("Network Defense")
	cyber_command.add_specialization("Cryptography")
	cyber_command.update_readiness(0.8)

# Initialize Special Operations
func initialize_special_operations():
	user_military.create_branch(BRANCH_SPECIAL_OPERATIONS, 70000, 15000000000.0)
	var special_ops = user_military.get_branch(BRANCH_SPECIAL_OPERATIONS)
	special_ops.add_equipment("Special Operations Aircraft", 100)
	special_ops.add_equipment("Special Operations Vehicle", 1000)
	special_ops.add_equipment("Advanced Small Arms", 50000)
	special_ops.add_equipment("Night Vision Device", 100000)
	special_ops.add_specialization("Counter-Terrorism")
	special_ops.add_specialization("Unconventional Warfare")
	special_ops.add_specialization("Special Reconnaissance")
	special_ops.add_specialization("Direct Action")
	special_ops.update_readiness(0.95)

# Function to get a summary of all military branches
func get_military_summary() -> String:
	var summary = "Military Forces Summary:\n"
	for branch_name in user_military.branches.keys():
		var branch = user_military.get_branch(branch_name)
		summary += "\n%s:\n" % branch_name
		summary += "  Personnel: %d\n" % branch.personnel
		summary += "  Budget: $%.2f billion\n" % (branch.budget / 1000000000.0)
		summary += "  Readiness: %.2f%%\n" % (branch.readiness_level * 100)
		summary += "  Specializations: %s\n" % ", ".join(branch.specializations)
	
	summary += "\nTotal Personnel: %d\n" % user_military.total_personnel
	summary += "Total Budget: $%.2f billion\n" % (user_military.total_budget / 1000000000.0)
	summary += "Overall Readiness: %.2f%%\n" % (user_military.get_total_readiness() * 100)
	
	return summary

# Function to simulate a year of military operations
func simulate_year():
	for branch in user_military.branches.values():
		# Simulate personnel changes
		var personnel_change = randi() % 10001 - 5000  # Random change between -5000 and 5000
		if personnel_change > 0:
			branch.recruit_personnel(personnel_change)
		else:
			branch.discharge_personnel(-personnel_change)
		
		# Simulate budget changes
		var budget_change = (randf() - 0.5) * 2000000000  # Random change between -1 and 1 billion
		if budget_change > 0:
			branch.increase_budget(budget_change)
		else:
			branch.decrease_budget(-budget_change)
		
		# Simulate readiness changes
		var readiness_change = (randf() - 0.5) * 0.1  # Random change between -0.05 and 0.05
		branch.update_readiness(branch.readiness_level + readiness_change)
	
	user_military.update_totals()

# Function to handle inter-branch transfers
func transfer_resources(from_branch: String, to_branch: String, personnel: int, budget: float):
	user_military.transfer_personnel(from_branch, to_branch, personnel)
	user_military.reallocate_budget(from_branch, to_branch, budget)

# Function to upgrade equipment for a specific branch
func upgrade_equipment(branch_name: String, equipment_name: String, quantity: int, cost: float):
	var branch = user_military.get_branch(branch_name)
	if branch and branch.budget >= cost:
		branch.add_equipment(equipment_name, quantity)
		branch.decrease_budget(cost)
		branch.update_readiness(min(branch.readiness_level + 0.05, 1.0))
		user_military.update_totals()
		return true
	return false

# Function to add a new specialization to a branch
func add_branch_specialization(branch_name: String, specialization: String):
	var branch = user_military.get_branch(branch_name)
	if branch and not specialization in branch.specializations:
		branch.add_specialization(specialization)
		branch.update_readiness(min(branch.readiness_level + 0.02, 1.0))
		return true
	return false

# Function to simulate a military conflict
func simulate_conflict(enemy_strength: float) -> bool:
	var total_strength = 0.0
	for branch in user_military.branches.values():
		total_strength += branch.personnel * branch.readiness_level
	
	var victory_chance = total_strength / (total_strength + enemy_strength)
	var result = randf() < victory_chance
	
	# Update readiness based on conflict outcome
	for branch in user_military.branches.values():
		if result:
			branch.update_readiness(min(branch.readiness_level + 0.1, 1.0))
		else:
			branch.update_readiness(max(branch.readiness_level - 0.15, 0.0))
	
	return result

# Main game loop function
func _process(delta):
	# Add any
