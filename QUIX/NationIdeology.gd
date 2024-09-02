
extends Node

class_name NationIdeology

# Enum to define different ideologies
enum Ideology {
    DEMOCRACY,
    COMMUNISM,
    FASCISM,
    MONARCHY,
    THEOCRACY,
    ANARCHISM,
    SOCIALISM,
    CAPITALISM,
    ENVIRONMENTALISM,
    TECHNOCRACY
}

# Dictionary to store ideology colors
const IDEOLOGY_COLORS = {
    Ideology.DEMOCRACY: Color(0.0, 0.5, 1.0),  # Blue
    Ideology.COMMUNISM: Color(1.0, 0.0, 0.0),  # Red
    Ideology.FASCISM: Color(0.5, 0.5, 0.5),    # Gray
    Ideology.MONARCHY: Color(0.8, 0.0, 0.8),   # Purple
    Ideology.THEOCRACY: Color(1.0, 0.84, 0.0), # Gold
    Ideology.ANARCHISM: Color(0.0, 0.0, 0.0),  # Black
    Ideology.SOCIALISM: Color(1.0, 0.65, 0.0), # Orange
    Ideology.CAPITALISM: Color(0.0, 0.8, 0.0), # Green
    Ideology.ENVIRONMENTALISM: Color(0.13, 0.55, 0.13), # Forest Green
    Ideology.TECHNOCRACY: Color(0.0, 1.0, 1.0) # Cyan
}

# Current ideology of the nation
var current_ideology: int = Ideology.DEMOCRACY

# Signal to notify when ideology changes
signal ideology_changed(new_ideology)

# Function to get the current ideology
func get_current_ideology() -> int:
    return current_ideology

# Function to get the color of the current ideology
func get_current_ideology_color() -> Color:
    return IDEOLOGY_COLORS[current_ideology]

# Function to switch ideology
func switch_ideology(new_ideology: int) -> void:
    if new_ideology in Ideology.values():
        current_ideology = new_ideology
        emit_signal("ideology_changed", current_ideology)
    else:
        push_error("Invalid ideology selected")

# Function to get ideology name as string
func get_ideology_name(ideology: int) -> String:
    return Ideology.keys()[ideology]

# Function to get all available ideologies
func get_all_ideologies() -> Array:
    return Ideology.values()

# Function to get ideology description
func get_ideology_description(ideology: int) -> String:
    match ideology:
        Ideology.DEMOCRACY:
            return "A system of government by the whole population or all eligible members of a state, typically through elected representatives."
        Ideology.COMMUNISM:
            return "A theory or system of social organization in which all property and wealth are communally-owned, instead of by individuals."
        Ideology.FASCISM:
            return "An authoritarian and nationalistic right-wing system of government and social organization."
        Ideology.MONARCHY:
            return "A form of government with a monarch at the head."
        Ideology.THEOCRACY:
            return "A system of government in which priests rule in the name of God or a god."
        Ideology.ANARCHISM:
            return "Belief in the abolition of all government and the organization of society on a voluntary, cooperative basis without recourse to force or compulsion."
        Ideology.SOCIALISM:
            return "A political and economic theory of social organization which advocates that the means of production, distribution, and exchange should be owned or regulated by the community as a whole."
        Ideology.CAPITALISM:
            return "An economic and political system in which a country's trade and industry are controlled by private owners for profit, rather than by the state."
        Ideology.ENVIRONMENTALISM:
            return "Concern about and action aimed at protecting the environment."
        Ideology.TECHNOCRACY:
            return "The government or control of society or industry by an elite of technical experts."
        _:
            return "Unknown ideology"

# Function to calculate ideology popularity
func calculate_ideology_popularity(ideology: int) -> float:
    # This is a placeholder function. In a real game, this would be based on various factors.
    # For now, we'll return a random value between 0 and 1
    randomize()
    return randf()

# Function to get ideology effects on economy
func get_ideology_economic_effects(ideology: int) -> Dictionary:
    match ideology:
        Ideology.DEMOCRACY:
            return {"gdp_growth": 0.03, "unemployment": -0.02, "inflation": 0.02}
        Ideology.COMMUNISM:
            return {"gdp_growth": -0.01, "unemployment": -0.05, "inflation": 0.05}
        Ideology.FASCISM:
            return {"gdp_growth": 0.04, "unemployment": -0.03, "inflation": 0.04}
        Ideology.MONARCHY:
            return {"gdp_growth": 0.02, "unemployment": 0.01, "inflation": 0.02}
        Ideology.THEOCRACY:
            return {"gdp_growth": 0.01, "unemployment": 0.02, "inflation": 0.01}
        Ideology.ANARCHISM:
            return {"gdp_growth": -0.02, "unemployment": 0.05, "inflation": 0.06}
        Ideology.SOCIALISM:
            return {"gdp_growth": 0.02, "unemployment": -0.04, "inflation": 0.03}
        Ideology.CAPITALISM:
            return {"gdp_growth": 0.04, "unemployment": 0.02, "inflation": 0.02}
        Ideology.ENVIRONMENTALISM:
            return {"gdp_growth": 0.01, "unemployment": 0.01, "inflation": 0.01}
        Ideology.TECHNOCRACY:
            return {"gdp_growth": 0.05, "unemployment": -0.01, "inflation": 0.02}
        _:
            return {"gdp_growth": 0, "unemployment": 0, "inflation": 0}

# Function to get ideology effects on diplomacy
func get_ideology_diplomacy_effects(ideology: int) -> Dictionary:
    match ideology:
        Ideology.DEMOCRACY:
            return {"relations_with_democracies": 0.05, "relations_with_autocracies": -0.03}
        Ideology.COMMUNISM:
            return {"relations_with_democracies": -0.05, "relations_with_autocracies": 0.03}
        Ideology.FASCISM:
            return {"relations_with_democracies": -0.07, "relations_with_autocracies": 0.02}
        Ideology.MONARCHY:
            return {"relations_with_democracies": -0.02, "relations_with_autocracies": 0.02}
        Ideology.THEOCRACY:
            return {"relations_with_democracies": -0.03, "relations_with_autocracies": 0.01}
        Ideology.ANARCHISM:
            return {"relations_with_democracies": -0.04, "relations_with_autocracies": -0.04}
        Ideology.SOCIALISM:
            return {"relations_with_democracies": 0.02, "relations_with_autocracies": 0.01}
        Ideology.CAPITALISM:
            return {"relations_with_democracies": 0.04, "relations_with_autocracies": -0.01}
        Ideology.ENVIRONMENTALISM:
            return {"relations_with_democracies": 0.03, "relations_with_autocracies": 0.01}
        Ideology.TECHNOCRACY:
            return {"relations_with_democracies": 0.02, "relations_with_autocracies": 0.02}
        _:
            return {"relations_with_democracies": 0, "relations_with_autocracies": 0}

# Function to simulate ideology transition
func simulate_ideology_transition(from_ideology: int, to_ideology: int) -> Dictionary:
    var transition_time = randi() % 5 + 1  # Random transition time between 1 to 5 years
    var stability_impact = randf() * -0.5  # Random stability impact between -0.5 to 0
    var population_approval = randf() * 2 - 1  # Random approval between -1 to 1
    
    return {
        "transition_time": transition_time,
        "stability_impact": stability_impact,
        "population_approval": population_approval
    }

# Function to get ideology-specific events
func get_ideology_events(ideology: int) -> Array:
    match ideology:
        Ideology.DEMOCRACY:
            return ["Election Day", "Constitutional Reform"]
        Ideology.COMMUNISM:
            return ["Five-Year Plan Announcement", "Collective Farm Initiative"]
        Ideology.FASCISM:
            return ["Military Parade", "Nationalist Rally"]
        Ideology.MONARCHY:
            return ["Royal Wedding", "Coronation Ceremony"]
        Ideology.THEOCRACY:
            return ["Religious Festival", "Divine Mandate Proclamation"]
        Ideology.ANARCHISM:
            return ["Autonomous Zone Declaration", "Anti-Government Protest"]
        Ideology.SOCIALISM:
            return ["Workers' Rights March", "Public Service Expansion"]
        Ideology.CAPITALISM:
            return ["Stock Market Boom", "Free Trade Agreement"]
        Ideology.ENVIRONMENTALISM:
            return ["Green Energy Initiative", "Wildlife Conservation Project"]
        Ideology.TECHNOCRACY:
            return ["AI Governance Proposal", "National Innovation Fair"]
        _:
            return []

# Function to calculate ideology stability
func calculate_ideology_stability(ideology: int, years_in_power: int) -> float:
    var base_stability = 0.5
    var time_factor = min(years_in_power / 10.0, 1.0)  # Max out at 10 years
    
    match ideology:
        Ideology.DEMOCRACY:
            return base_stability + (0.3 * time_factor)
        Ideology.COMMUNISM:
            return base_stability + (0.1 * time_factor)
        Ideology.FASCISM:
            return base_stability + (0.2 * time_factor)
        Ideology.MONARCHY:
            return base_stability + (0.4 * time_factor)
        Ideology.THEOCRACY:
            return base_stability + (0.3 * time_factor)
        Ideology.ANARCHISM:
            return base_stability - (0.2 * time_factor)
        Ideology.SOCIALISM:
            return base_stability + (0.2 * time_factor)
        Ideology.CAPITALISM:
            return base_stability + (0.3 * time_factor)
        Ideology.ENVIRONMENTALISM:
            return base_stability + (0.1 * time_factor)
        Ideology.TECHNOCRACY:
            return base_stability + (0.2 * time_factor)
        _:
            return base_stability

# Function to get ideology-specific policies
func get_ideology_policies(ideology: int) -> Array:
    match ideology:
        Ideology.DEMOCRACY:
            return ["Universal Suffrage", "Freedom of Press", "Separation of Powers"]
        Ideology.COMMUNISM:
            return ["Collective Ownership", "Planned Economy", "Abolition of Private Property"]
        Ideology.FASCISM:
            return ["Ultranationalism", "Totalitarian Control", "Militarism"]
        Ideology.MONARCHY:
            return ["Hereditary Rule", "Noble Privileges", "Royal Decrees"]
        Ideology.THEOCRACY:
            return ["Religious Law", "Clergy in Government", "State Religion"]
        Ideology.ANARCHISM:
            return ["Abolition of State", "Direct Action", "Mutual Aid"]
        Ideology.SOCIALISM:
            return ["Workers' Control", "Social Welfare", "Progressive Taxation"]
        Ideology.CAPITALISM:
            return ["Free Market", "Private Property Rights", "Minimal Government Intervention"]
        Ideology.ENVIRONMENTALISM:
            return ["Green Energy", "Conservation Laws", "Sustainable Development"]
        Ideology.TECHNOCRACY:
            return ["Merit-based Governance", "Scientific Decision Making", "Technological Progress"]
        _:
            return []

# Function to simulate international reaction to ideology change
func simulate_international_reaction(from_ideology: int, to_ideology: int) -> Dictionary:
    var democratic_reaction = 0.0
    var autocratic_reaction = 0.0
    
    # Calculate reactions based on ideology shift
    if to_ideology == Ideology.DEMOCRACY:
        democratic_reaction = 0.5
        autocratic_reaction = -0.3
    elif to_ideology in [Ideology.COMMUNISM, Ideology.FASCISM]:
        democratic_reaction = -0.7
        autocratic_reaction = 0.3
    
    return {
        "democratic_nations_reaction": democratic_reaction,
        "autocratic_nations_reaction": autocratic_reaction,
        "un_response": "Concerned" if democratic_reaction < 0 else "Supportive",
        "potential_sanctions": democratic_reaction < -0.5
    }

# Function to get ideology impact on research and development
func get_ideology_research_impact(ideology: int) -> Dictionary:
    match ideology:
        Ideology.DEMOCRACY:
            return {"research_speed": 1.1, "innovation_rate": 1.2}
        Ideology.COMMUNISM:
            return {"research_speed": 0.9, "innovation_rate": 0.8}
        Ideology.FASCISM:
            return {"research_speed": 1.0, "innovation_rate": 0.9}
        Ideology.MONARCHY:
            return {"research_speed": 0.9, "innovation_rate": 0.9}
        Ideology.THEOCRACY:
            return {"research_speed": 0.8, "innovation_rate": 0.7}
        Ideology.ANARCHISM:
            return {"research_speed": 0.7, "innovation_rate": 1.1}
        Ideology.SOCIALISM:
            return {"research_speed": 1.0, "innovation_rate": 1.0}
        Ideology.CAPITALISM:
            return {"research_speed": 1.2, "innovation_rate": 1.3}
        Ideology.ENVIRONMENTALISM:
            return {"research_speed": 1.1, "innovation_rate": 1.1}
        Ideology.TECHNOCRACY:
            return {"research_speed": 1.3, "innovation_rate": 1.4}
        _:
            return {"research_speed": 1.0, "innovation_rate": 1.0}

# Function to calculate ideology approval rating
func calculate_ideology_approval(ideology: int, economic_growth: float, unemployment_rate: float) -> float:
    var base_approval = 0.5
    var economic_factor = clamp(economic_growth, -0.1, 0.1) * 5  # -0.5 to 0.5
    var unemployment_factor = clamp(unemployment_rate, 0, 0.2) * -2.5  # -0.5 to 0
    
    var ideology_specific_factor = 0.0
    match ideology:
        Ideology.DEMOCRACY:
            ideology_specific_factor = 0.1
        Ideology.COMMUNISM:
            ideology_specific_factor = -0.1
        Ideology.FASCISM:
            ideology_specific_factor = -0.2
        Ideology.MONARCHY:
            ideology_specific_factor = 0.0
        Ideology.THEOCRACY:
            ideology_specific_factor = -0.1
        Ideology.ANARCHISM:
            ideology_specific_factor = -0.3
        Ideology.SOCIALISM:
            ideology_specific_factor = 0.0
        Ideology.CAPITALISM:
            ideology_specific_factor = 0.1
        Ideology.ENVIRONMENTALISM:
            ideology_specific_factor = 0.0
        Ideology.TECHNOCRACY:
            ideology_specific
