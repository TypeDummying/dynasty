
import random
import json
import os
from typing import Dict, List, Optional

class Country:
    def __init__(self, name: str, capital: str, population: int, gdp: float, military_strength: int):
        self.name = name
        self.capital = capital
        self.population = population
        self.gdp = gdp
        self.military_strength = military_strength
        self.resources: Dict[str, int] = {}
        self.allies: List[str] = []
        self.enemies: List[str] = []
        self.technology_level: int = 1
        self.happiness: float = 50.0  # Percentage

    def add_resource(self, resource: str, amount: int) -> None:
        """Add a resource to the country."""
        self.resources[resource] = amount

    def add_ally(self, country_name: str) -> None:
        """Add an ally to the country."""
        if country_name not in self.allies:
            self.allies.append(country_name)

    def add_enemy(self, country_name: str) -> None:
        """Add an enemy to the country."""
        if country_name not in self.enemies:
            self.enemies.append(country_name)

    def increase_technology(self) -> None:
        """Increase the technology level of the country."""
        self.technology_level += 1

    def adjust_happiness(self, amount: float) -> None:
        """Adjust the happiness level of the country's population."""
        self.happiness = max(0, min(100, self.happiness + amount))

    def to_dict(self) -> Dict:
        """Convert the country object to a dictionary for saving."""
        return {
            "name": self.name,
            "capital": self.capital,
            "population": self.population,
            "gdp": self.gdp,
            "military_strength": self.military_strength,
            "resources": self.resources,
            "allies": self.allies,
            "enemies": self.enemies,
            "technology_level": self.technology_level,
            "happiness": self.happiness
        }

    @classmethod
    def from_dict(cls, data: Dict) -> 'Country':
        """Create a Country object from a dictionary."""
        country = cls(
            data["name"],
            data["capital"],
            data["population"],
            data["gdp"],
            data["military_strength"]
        )
        country.resources = data["resources"]
        country.allies = data["allies"]
        country.enemies = data["enemies"]
        country.technology_level = data["technology_level"]
        country.happiness = data["happiness"]
        return country

class CustomCountriesMaker:
    def __init__(self):
        self.countries: Dict[str, Country] = {}
        self.game_year: int = 2023
        self.player_country: Optional[str] = None

    def create_country(self) -> None:
        """Create a new country based on user input."""
        print("\n=== Create a New Country ===")
        name = input("Enter country name: ")
        capital = input("Enter capital city: ")
        population = int(input("Enter population: "))
        gdp = float(input("Enter GDP (in billions): "))
        military_strength = int(input("Enter military strength (1-100): "))

        country = Country(name, capital, population, gdp, military_strength)

        # Add resources
        while True:
            resource = input("Enter a resource (or press Enter to finish): ")
            if not resource:
                break
            amount = int(input(f"Enter amount of {resource}: "))
            country.add_resource(resource, amount)

        self.countries[name] = country
        print(f"{name} has been created successfully!")

    def list_countries(self) -> None:
        """List all created countries."""
        print("\n=== List of Countries ===")
        for name, country in self.countries.items():
            print(f"- {name} (Capital: {country.capital}, Population: {country.population:,})")

    def view_country_details(self) -> None:
        """View detailed information about a specific country."""
        name = input("Enter country name to view details: ")
        country = self.countries.get(name)
        if country:
            print(f"\n=== {name} Details ===")
            print(f"Capital: {country.capital}")
            print(f"Population: {country.population:,}")
            print(f"GDP: ${country.gdp:.2f} billion")
            print(f"Military Strength: {country.military_strength}")
            print("Resources:")
            for resource, amount in country.resources.items():
                print(f"  - {resource}: {amount}")
            print(f"Allies: {', '.join(country.allies)}")
            print(f"Enemies: {', '.join(country.enemies)}")
            print(f"Technology Level: {country.technology_level}")
            print(f"Happiness: {country.happiness:.1f}%")
        else:
            print(f"Country '{name}' not found.")

    def modify_country(self) -> None:
        """Modify an existing country's attributes."""
        name = input("Enter country name to modify: ")
        country = self.countries.get(name)
        if country:
            print(f"\n=== Modifying {name} ===")
            print("1. Change population")
            print("2. Change GDP")
            print("3. Change military strength")
            print("4. Add/modify resource")
            print("5. Add ally")
            print("6. Add enemy")
            print("7. Increase technology level")
            print("8. Adjust happiness")

            choice = input("Enter your choice (1-8): ")
            if choice == "1":
                country.population = int(input("Enter new population: "))
            elif choice == "2":
                country.gdp = float(input("Enter new GDP (in billions): "))
            elif choice == "3":
                country.military_strength = int(input("Enter new military strength (1-100): "))
            elif choice == "4":
                resource = input("Enter resource name: ")
                amount = int(input(f"Enter amount of {resource}: "))
                country.add_resource(resource, amount)
            elif choice == "5":
                ally = input("Enter ally country name: ")
                country.add_ally(ally)
            elif choice == "6":
                enemy = input("Enter enemy country name: ")
                country.add_enemy(enemy)
            elif choice == "7":
                country.increase_technology()
                print(f"Technology level increased to {country.technology_level}")
            elif choice == "8":
                amount = float(input("Enter happiness adjustment (-100 to 100): "))
                country.adjust_happiness(amount)
            else:
                print("Invalid choice.")
            print(f"{name} has been modified successfully!")
        else:
            print(f"Country '{name}' not found.")

    def delete_country(self) -> None:
        """Delete an existing country."""
        name = input("Enter country name to delete: ")
        if name in self.countries:
            del self.countries[name]
            print(f"{name} has been deleted successfully!")
        else:
            print(f"Country '{name}' not found.")

    def save_countries(self) -> None:
        """Save all countries to a JSON file."""
        data = {name: country.to_dict() for name, country in self.countries.items()}
        with open("countries.json", "w") as f:
            json.dump(data, f, indent=2)
        print("Countries saved successfully!")

    def load_countries(self) -> None:
        """Load countries from a JSON file."""
        if os.path.exists("countries.json"):
            with open("countries.json", "r") as f:
                data = json.load(f)
            self.countries = {name: Country.from_dict(country_data) for name, country_data in data.items()}
            print("Countries loaded successfully!")
        else:
            print("No saved countries found.")

    def start_game(self) -> None:
        """Start the game with the created countries."""
        if not self.countries:
            print("No countries available. Please create some countries first.")
            return

        print("\n=== Start Game ===")
        self.player_country = input("Choose your country: ")
        if self.player_country not in self.countries:
            print(f"Country '{self.player_country}' not found. Game cannot start.")
            return

        print(f"Game started! You are now leading {self.player_country}.")
        self.game_loop()

    def game_loop(self) -> None:
        """Main game loop for the Dynasty game."""
        while True:
            print(f"\n=== Year {self.game_year} ===")
            print(f"You are leading {self.player_country}")
            print("1. View country status")
            print("2. Manage resources")
            print("3. Diplomacy")
            print("4. Invest in technology")
            print("5. Military actions")
            print("6. End turn")
            print("7. End game")

            choice = input("Enter your choice (1-7): ")

            if choice == "1":
                self.view_country_details()
            elif choice == "2":
                self.manage_resources()
            elif choice == "3":
                self.diplomacy()
            elif choice == "4":
                self.invest_in_technology()
            elif choice == "5":
                self.military_actions()
            elif choice == "6":
                self.end_turn()
            elif choice == "7":
                print("Game over. Thanks for playing!")
                break
            else:
                print("Invalid choice. Please try again.")

    def manage_resources(self) -> None:
        """Manage country resources."""
        country = self.countries[self.player_country]
        print("\n=== Manage Resources ===")
        print("Current resources:")
        for resource, amount in country.resources.items():
            print(f"  - {resource}: {amount}")

        resource = input("Enter resource to manage (or press Enter to cancel): ")
        if resource in country.resources:
            action = input("Do you want to (I)ncrease or (D)ecrease the resource? ").lower()
            if action == 'i':
                amount = int(input("Enter amount to increase: "))
                country.resources[resource] += amount
                print(f"{resource} increased by {amount}")
            elif action == 'd':
                amount = int(input("Enter amount to decrease: "))
                country.resources[resource] = max(0, country.resources[resource] - amount)
                print(f"{resource} decreased by {amount}")
            else:
                print("Invalid action.")
        elif resource:
            print(f"Resource '{resource}' not found.")

    def diplomacy(self) -> None:
        """Manage diplomatic relations with other countries."""
        country = self.countries[self.player_country]
        print("\n=== Diplomacy ===")
        print("1. View current relations")
        print("2. Propose alliance")
        print("3. Declare rivalry")

        choice = input("Enter your choice (1-3): ")
        if choice == "1":
            print("Allies:", ", ".join(country.allies))
            print("Enemies:", ", ".join(country.enemies))
        elif choice == "2":
            ally = input("Enter country name to propose alliance: ")
            if ally in self.countries and ally != self.player_country:
                if random.random() < 0.7:  # 70% chance of success
                    country.add_ally(ally)
                    self.countries[ally].add_ally(self.player_country)
                    print(f"Alliance with {ally} established!")
                else:
                    print(f"{ally} rejected your alliance proposal.")
            else:
                print("Invalid country name.")
        elif choice == "3":
            enemy = input("Enter country name to declare rivalry: ")
            if enemy in self.countries and enemy != self.player_country:
                country.add_enemy(enemy)
                self.countries[enemy].add_enemy(self.player_country)
                print(f"Rivalry with {enemy} declared!")
            else:
                print("Invalid country name.")
        else:
            print("Invalid choice.")

    def invest_in_technology(self) -> None:
        """Invest in technology to increase the country's technology level."""
        country = self.countries[self.player_country]
        cost = country.technology_level * 1000000000  # Cost increases with each level
        print(f"\n=== Invest in Technology ===")
        print(f"Current technology level: {country.technology_level}")
        print(f"Cost to upgrade: ${cost/1000000000:.2f} billion")

        if country.gdp >= cost:
            choice = input("Do you want to invest in technology? (y/n): ").lower()
            if choice == 'y':
                country.gdp -= cost
                country.increase_technology()
                print(f"Technology level increased to {country.technology_level}!")
                country.adjust_happiness(5)  # People are happy with technological progress
            else:
                print("Investment cancelled.")
        else:
            print("Insufficient funds for technology investment.")

    def military_actions(self) -> None:
        """Perform military actions."""
        country = self.countries[self.player_country]
        print("\n=== Military Actions ===")
        print("1. Increase military strength")
        print("2. Conduct military exercise")
        print("3. Declare war")

        choice = input("Enter your choice (1-3): ")
        if choice == "1":
            cost = country.military_strength * 1000000000
            print(f"Cost to increase military strength: ${cost/1000000000:.2f} billion")
            if country.gdp >= cost:
                confirm = input("Do you want to increase military strength? (y/n): ").lower()
                if confirm == 'y':
                    country.gdp -= cost
                    country.military_strength += 5
                    print(f"Military strength increased to {country.military_strength}!")
                    country.adjust_happiness(-2)  # People are slightly unhappy with military spending
                else:
                    print("Action cancelled.")
            else:
                print("Insufficient funds to increase military strength.")
        elif choice == "2":
            print("Conducting military exercise...")
            success = random.random() < 0.8  # 80% chance of successful exercise
            if success:
                print("Military exercise was successful!")
                country.military_strength += 2
                country.adjust_happiness(1)
            else:
                print("Military exercise faced some challenges.")
                country.military_strength -= 1
                country.adjust_happiness(-1)
        elif choice == "3":
            target = input("Enter the name of the country to declare war on: ")
            if target in self.countries and target != self.player_country:
                confirm = input(f"Are you sure you want to declare war on {target}? (y/n): ").lower()
                if confirm == 'y':
                    self.conduct_war(self.player_country, target)
                else:
                    print("War declaration cancelled.")
            else:
                print("Invalid target country.")
        else:
            print("Invalid choice.")

    def conduct_war(self, attacker: str, defender: str) -> None:
        """Simulate a war between two countries."""
        attacker_country = self.countries[attacker]
        defender_country = self.countries[defender]

        print(f"\n=== War: {attacker} vs {defender} ===")

        attacker_strength = attacker_country.military_strength * (1 + 0.1 * attacker_country.technology_level)
        defender_strength = defender_country.military_strength * (1 + 0.1 * defender_country.technology_level)

        if attacker_strength > defender_strength:
            winner = attacker
            
            winner.capitalize()