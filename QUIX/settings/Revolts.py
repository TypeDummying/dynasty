
# Revolts and Revolutions System for Dynasty Geopolitical Game

# Global flag to enable/disable revolts
Revolts_Enabled = True

import random
from datetime import datetime, timedelta
from typing import List, Dict, Tuple

# Ideology class to represent different revolutionary ideologies
class Ideology:
    def __init__(self, name: str, description: str, popularity: float):
        self.name = name
        self.description = description
        self.popularity = popularity  # 0.0 to 1.0

    def __str__(self):
        return f"{self.name} - {self.description}"

# Revolutionary group class
class RevolutionaryGroup:
    def __init__(self, name: str, ideology: Ideology, strength: float):
        self.name = name
        self.ideology = ideology
        self.strength = strength  # 0.0 to 1.0
        self.members = random.randint(100, 10000)
        self.founded_date = datetime.now() - timedelta(days=random.randint(30, 3650))

    def recruit_members(self):
        new_members = random.randint(10, 500)
        self.members += new_members
        self.strength = min(1.0, self.strength + (new_members / 10000))

    def __str__(self):
        return f"{self.name} ({self.ideology.name}) - Strength: {self.strength:.2f}, Members: {self.members}"

# Country class to represent the user's country
class Country:
    def __init__(self, name: str, population: int, stability: float):
        self.name = name
        self.population = population
        self.stability = stability  # 0.0 to 1.0
        self.government_type = "Democracy"  # Can be changed based on game mechanics
        self.revolutionary_groups: List[RevolutionaryGroup] = []

    def add_revolutionary_group(self, group: RevolutionaryGroup):
        self.revolutionary_groups.append(group)

    def calculate_revolt_risk(self) -> float:
        return sum(group.strength for group in self.revolutionary_groups) / len(self.revolutionary_groups)

    def __str__(self):
        return f"{self.name} - Population: {self.population}, Stability: {self.stability:.2f}"

# List of possible ideologies
ideologies = [
    Ideology("Communism", "Advocates for a classless society and common ownership of the means of production", 0.3),
    Ideology("Fascism", "Ultranationalist, authoritarian political ideology", 0.2),
    Ideology("Anarchism", "Believes in the abolition of all government and the organization of society on a voluntary, cooperative basis", 0.1),
    Ideology("Theocracy", "A form of government in which a deity is recognized as the supreme civil ruler", 0.15),
    Ideology("Democracy", "A system of government by the whole population or all eligible members of a state, typically through elected representatives", 0.5),
    Ideology("Monarchy", "A form of government with a monarch at the head", 0.25),
    Ideology("Socialism", "A political and economic theory of social organization which advocates that the means of production, distribution, and exchange should be owned or regulated by the community as a whole", 0.35),
    Ideology("Oligarchy", "A small group of people having control of a country or organization", 0.2),
    Ideology("Technocracy", "The government or control of society or industry by an elite of technical experts", 0.1),
]

# Function to generate a new revolutionary group
def generate_revolutionary_group(country: Country) -> RevolutionaryGroup:
    ideology = random.choice(ideologies)
    name = f"{ideology.name}ist {random.choice(['Front', 'Movement', 'Party', 'Alliance', 'Coalition'])}"
    strength = random.uniform(0.1, 0.5)
    return RevolutionaryGroup(name, ideology, strength)

# Function to simulate revolts and revolutions
def simulate_revolts(country: Country, days: int):
    if not Revolts_Enabled:
        print("Revolts are currently disabled.")
        return

    for _ in range(days):
        # Simulate daily events
        for group in country.revolutionary_groups:
            group.recruit_members()

        # Check for new revolutionary groups
        if random.random() < 0.05:  # 5% chance each day
            new_group = generate_revolutionary_group(country)
            country.add_revolutionary_group(new_group)
            print(f"New revolutionary group formed: {new_group}")

        # Check for revolts
        revolt_risk = country.calculate_revolt_risk()
        if random.random() < revolt_risk:
            # Revolt occurs
            revolting_group = max(country.revolutionary_groups, key=lambda g: g.strength)
            print(f"Revolt by {revolting_group.name}!")
            
            # Simulate revolt outcome
            government_strength = country.stability * random.uniform(0.8, 1.2)
            if revolting_group.strength > government_strength:
                # Successful revolution
                print(f"The {revolting_group.name} has successfully overthrown the government!")
                country.government_type = revolting_group.ideology.name
                country.stability = max(0.1, country.stability - 0.3)
                country.revolutionary_groups = [g for g in country.revolutionary_groups if g != revolting_group]
            else:
                # Failed revolt
                print(f"The government has suppressed the revolt by {revolting_group.name}.")
                revolting_group.strength *= 0.7
                country.stability = min(1.0, country.stability + 0.1)

        # Update country stability
        country.stability = max(0.1, min(1.0, country.stability + random.uniform(-0.05, 0.05)))

# Function to initialize the revolt system for a country
def initialize_revolt_system(country: Country):
    num_initial_groups = random.randint(2, 5)
    for _ in range(num_initial_groups):
        country.add_revolutionary_group(generate_revolutionary_group(country))

# Main function to run the revolt simulation
def run_revolt_simulation(country_name: str, population: int, initial_stability: float, simulation_days: int):
    country = Country(country_name, population, initial_stability)
    initialize_revolt_system(country)

    print(f"Initial state of {country}")
    print("Initial revolutionary groups:")
    for group in country.revolutionary_groups:
        print(f"- {group}")

    print(f"\nSimulating {simulation_days} days of potential revolts and revolutions...")
    simulate_revolts(country, simulation_days)

    print(f"\nFinal state of {country}")
    print("Final revolutionary groups:")
    for group in country.revolutionary_groups:
        print(f"- {group}")

# Example usage
if __name__ == "__main__":
    run_revolt_simulation("Exampleland", 10000000, 0.7, 365)
