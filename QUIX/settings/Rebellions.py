
# Rebellions Module for Dynasty Geopolitical Game
# This module handles the generation and management of rebellions within a country

import random
from typing import List, Dict, Tuple
from datetime import datetime, timedelta

# Configuration
Rebelling_Enabled = True  # Set to False to disable rebellions

# Constants
IDEOLOGY_TYPES = [
    "Communist", "Fascist", "Democratic", "Monarchist", "Theocratic",
    "Anarchist", "Socialist", "Capitalist", "Environmentalist", "Nationalist"
]

REBELLION_TRIGGERS = [
    "Economic Crisis", "Political Oppression", "Foreign Influence",
    "Ethnic Tensions", "Religious Conflicts", "Resource Scarcity",
    "Technological Disruption", "Climate Change", "Corruption Scandal"
]

class Rebel:
    def __init__(self, name: str, ideology: str, charisma: int, military_exp: int):
        self.name = name
        self.ideology = ideology
        self.charisma = charisma
        self.military_exp = military_exp

class Rebellion:
    def __init__(self, ideology: str, leader: Rebel, strength: int, trigger: str):
        self.ideology = ideology
        self.leader = leader
        self.strength = strength
        self.trigger = trigger
        self.start_date = datetime.now()
        self.active = True

class Country:
    def __init__(self, name: str, stability: int, military_strength: int):
        self.name = name
        self.stability = stability
        self.military_strength = military_strength
        self.active_rebellions: List[Rebellion] = []

def generate_rebel_name() -> str:
    first_names = ["John", "Emma", "Liu", "Mohammed", "Olga", "Carlos", "Fatima", "Raj", "Yuki", "Kwame"]
    last_names = ["Smith", "Zhang", "Patel", "Müller", "Garcia", "Nguyen", "Kim", "Okafor", "Silva", "Tanaka"]
    return f"{random.choice(first_names)} {random.choice(last_names)}"

def create_rebel() -> Rebel:
    return Rebel(
        name=generate_rebel_name(),
        ideology=random.choice(IDEOLOGY_TYPES),
        charisma=random.randint(1, 100),
        military_exp=random.randint(1, 100)
    )

def calculate_rebellion_strength(leader: Rebel, country: Country) -> int:
    base_strength = random.randint(10, 50)
    leader_factor = (leader.charisma + leader.military_exp) / 2
    country_weakness = 100 - country.stability
    
    return int(base_strength * (1 + leader_factor / 100) * (1 + country_weakness / 100))

def create_rebellion(country: Country) -> Rebellion:
    leader = create_rebel()
    strength = calculate_rebellion_strength(leader, country)
    trigger = random.choice(REBELLION_TRIGGERS)
    
    return Rebellion(leader.ideology, leader, strength, trigger)

def check_rebellion_chance(country: Country) -> bool:
    base_chance = 0.01  # 1% daily chance
    stability_factor = 1 - (country.stability / 100)
    daily_chance = base_chance * (1 + stability_factor)
    
    return random.random() < daily_chance

def resolve_rebellion(rebellion: Rebellion, country: Country) -> Tuple[bool, str]:
    government_strength = country.military_strength * (country.stability / 100)
    rebellion_strength = rebellion.strength * (1 + (datetime.now() - rebellion.start_date).days / 365)
    
    if government_strength > rebellion_strength:
        country.stability = max(country.stability - 5, 0)
        return False, f"The {rebellion.ideology} rebellion led by {rebellion.leader.name} has been crushed."
    else:
        new_ideology = rebellion.ideology
        return True, f"The {rebellion.ideology} rebellion led by {rebellion.leader.name} has succeeded. The government has been overthrown."

def update_rebellions(country: Country) -> List[str]:
    if not Rebelling_Enabled:
        return []

    events = []

    # Check for new rebellions
    if check_rebellion_chance(country):
        new_rebellion = create_rebellion(country)
        country.active_rebellions.append(new_rebellion)
        events.append(f"A new {new_rebellion.ideology} rebellion has started in {country.name}, led by {new_rebellion.leader.name}. Trigger: {new_rebellion.trigger}")

    # Resolve ongoing rebellions
    for rebellion in country.active_rebellions:
        if random.random() < 0.1:  # 10% daily chance of resolution attempt
            success, message = resolve_rebellion(rebellion, country)
            events.append(message)
            if success:
                country.active_rebellions.remove(rebellion)
                # Implement government change logic here
            else:
                rebellion.active = False
                country.active_rebellions.remove(rebellion)

    return events

def simulate_country(country: Country, days: int) -> List[str]:
    all_events = []
    for _ in range(days):
        daily_events = update_rebellions(country)
        all_events.extend(daily_events)
    
    return all_events

# Example usage
if __name__ == "__main__":
    example_country = Country("Exampleland", stability=70, military_strength=80)
    simulation_events = simulate_country(example_country, 365)
    
    print(f"Simulation results for {example_country.name}:")
    for event in simulation_events:
        print(event)
    
    print(f"\nFinal country status:")
    print(f"Stability: {example_country.stability}")
    print(f"Active rebellions: {len(example_country.active_rebellions)}")
