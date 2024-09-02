
import random
from typing import List, Dict, Tuple
from solo_game import SoloGame # type: ignore
from map_generator import MapGenerator # type: ignore
from continent import Continent # type: ignore
from region import Region # type: ignore
from utils import validate_input, generate_unique_id # type: ignore

class CustomContinentCreator:
    def __init__(self, solo_game: SoloGame):
        self.solo_game = solo_game
        self.map_generator = MapGenerator()

    def create_custom_continent(self) -> Continent:
        """
        Main method to create a custom continent for the Dynasty geo-politics game.
        """
        print("Welcome to the Custom Continent Creator!")
        
        # Step 1: Get continent name
        continent_name = self._get_continent_name()
        
        # Step 2: Define continent size
        continent_size = self._define_continent_size()
        
        # Step 3: Generate regions
        regions = self._generate_regions(continent_size)
        
        # Step 4: Set continent climate
        climate = self._set_continent_climate()
        
        # Step 5: Define continent resources
        resources = self._define_continent_resources()
        
        # Step 6: Set continent political system
        political_system = self._set_political_system()
        
        # Step 7: Generate unique continent ID
        continent_id = generate_unique_id()
        
        # Create and return the new continent
        return Continent(continent_id, continent_name, regions, climate, resources, political_system)

    def _get_continent_name(self) -> str:
        """
        Prompt the user to input a name for the custom continent.
        """
        while True:
            name = input("Enter a name for your custom continent: ").strip()
            if validate_input(name, min_length=3, max_length=50, allowed_chars="alphanumeric"):
                return name
            print("Invalid name. Please use 3-50 alphanumeric characters.")

    def _define_continent_size(self) -> str:
        """
        Let the user choose the size of the continent.
        """
        sizes = ["small", "medium", "large"]
        print("Choose the size of your continent:")
        for i, size in enumerate(sizes, 1):
            print(f"{i}. {size.capitalize()}")
        
        while True:
            choice = input("Enter the number of your choice: ")
            if choice.isdigit() and 1 <= int(choice) <= len(sizes):
                return sizes[int(choice) - 1]
            print("Invalid choice. Please enter a number from the list.")

    def _generate_regions(self, continent_size: str) -> List[Region]:
        """
        Generate a list of regions based on the continent size.
        """
        region_counts = {"small": 5, "medium": 8, "large": 12}
        num_regions = region_counts[continent_size]
        
        regions = []
        for i in range(num_regions):
            region_name = f"Region {i+1}"
            region_id = generate_unique_id()
            region_type = random.choice(["coastal", "inland", "mountainous", "forest", "desert"])
            region = Region(region_id, region_name, region_type)
            regions.append(region)
        
        return regions

    def _set_continent_climate(self) -> str:
        """
        Allow the user to set the overall climate of the continent.
        """
        climates = ["tropical", "arid", "temperate", "continental", "polar"]
        print("Choose the primary climate for your continent:")
        for i, climate in enumerate(climates, 1):
            print(f"{i}. {climate.capitalize()}")
        
        while True:
            choice = input("Enter the number of your choice: ")
            if choice.isdigit() and 1 <= int(choice) <= len(climates):
                return climates[int(choice) - 1]
            print("Invalid choice. Please enter a number from the list.")

    def _define_continent_resources(self) -> Dict[str, int]:
        """
        Define the resources available in the continent.
        """
        resources = {
            "gold": 0,
            "iron": 0,
            "wood": 0,
            "food": 0,
            "oil": 0
        }
        
        print("Define the abundance of resources in your continent (0-10):")
        for resource in resources:
            while True:
                value = input(f"{resource.capitalize()} abundance (0-10): ")
                if value.isdigit() and 0 <= int(value) <= 10:
                    resources[resource] = int(value)
                    break
                print("Invalid input. Please enter a number between 0 and 10.")
        
        return resources

    def _set_political_system(self) -> str:
        """
        Allow the user to set the initial political system of the continent.
        """
        systems = ["democracy", "monarchy", "dictatorship", "oligarchy", "anarchy"]
        print("Choose the initial political system for your continent:")
        for i, system in enumerate(systems, 1):
            print(f"{i}. {system.capitalize()}")
        
        while True:
            choice = input("Enter the number of your choice: ")
            if choice.isdigit() and 1 <= int(choice) <= len(systems):
                return systems[int(choice) - 1]
            print("Invalid choice. Please enter a number from the list.")

    def generate_continent_history(self, continent: Continent) -> List[str]:
        """
        Generate a brief history for the custom continent.
        """
        events = [
            f"{continent.name} was formed through a cataclysmic geological event.",
            f"The first settlers arrived on {continent.name} approximately 10,000 years ago.",
            f"A great civilization rose and fell on {continent.name} 5,000 years ago.",
            f"The current political system ({continent.political_system}) was established 500 years ago.",
            f"A significant technological advancement occurred on {continent.name} 100 years ago."
        ]
        return events

    def add_custom_landmarks(self, continent: Continent) -> List[Tuple[str, str]]:
        """
        Allow the user to add custom landmarks to the continent.
        """
        landmarks = []
        print("Add custom landmarks to your continent (enter 'done' when finished):")
        while True:
            name = input("Enter landmark name (or 'done' to finish): ").strip()
            if name.lower() == 'done':
                break
            description = input("Enter a brief description of the landmark: ").strip()
            landmarks.append((name, description))
        return landmarks

    def customize_region_details(self, regions: List[Region]) -> None:
        """
        Allow the user to customize details for each region in the continent.
        """
        for region in regions:
            print(f"\nCustomizing details for {region.name}:")
            
            # Set population
            while True:
                population = input("Enter the population for this region: ")
                if population.isdigit() and int(population) >= 0:
                    region.population = int(population)
                    break
                print("Invalid input. Please enter a non-negative integer.")
            
            # Set development level
            while True:
                development = input("Enter the development level (0-10) for this region: ")
                if development.isdigit() and 0 <= int(development) <= 10:
                    region.development_level = int(development)
                    break
                print("Invalid input. Please enter a number between 0 and 10.")
            
            # Set primary industry
            industries = ["agriculture", "manufacturing", "services", "technology", "tourism"]
            print("Choose the primary industry for this region:")
            for i, industry in enumerate(industries, 1):
                print(f"{i}. {industry.capitalize()}")
            
            while True:
                choice = input("Enter the number of your choice: ")
                if choice.isdigit() and 1 <= int(choice) <= len(industries):
                    region.primary_industry = industries[int(choice) - 1]
                    break
                print("Invalid choice. Please enter a number from the list.")

    def generate_continent_challenges(self, continent: Continent) -> List[str]:
        """
        Generate a list of potential challenges or events that the continent might face.
        """
        challenges = [
            f"Economic recession in {random.choice(continent.regions).name}",
            f"Natural disaster affecting {random.choice(continent.regions).name}",
            f"Political uprising in {random.choice(continent.regions).name}",
            f"Technological breakthrough in {random.choice(continent.regions).name}",
            f"Diplomatic tension with neighboring continents",
            f"Resource scarcity crisis in {continent.name}",
            f"Cultural renaissance in {random.choice(continent.regions).name}",
            f"Major migration wave to {continent.name}",
            f"Environmental protection movement in {continent.name}",
            f"Space exploration initiative launched from {random.choice(continent.regions).name}"
        ]
        return random.sample(challenges, k=5)  # Return 5 random challenges

    def finalize_continent(self, continent: Continent) -> None:
        """
        Finalize the continent creation process and add it to the game world.
        """
        # Generate continent history
        continent.history = self.generate_continent_history(continent)
        
        # Add custom landmarks
        continent.landmarks = self.add_custom_landmarks(continent)
        
        # Customize region details
        self.customize_region_details(continent.regions)
        
        # Generate potential challenges
        continent.challenges = self.generate_continent_challenges(continent)
        
        # Add the continent to the game world
        self.solo_game.world.add_continent(continent)
        
        print(f"\nContinent '{continent.name}' has been successfully created and added to the game world!")
        print("Here's a summary of your new continent:")
        print(f"Name: {continent.name}")
        print(f"Size: {len(continent.regions)} regions")
        print(f"Climate: {continent.climate}")
        print(f"Political System: {continent.political_system}")
        print(f"Resources: {', '.join([f'{k}: {v}' for k, v in continent.resources.items()])}")
        print(f"Number of Landmarks: {len(continent.landmarks)}")
        print(f"Potential Challenges: {len(continent.challenges)}")

    def run(self) -> None:
        """
        Run the custom continent creation process.
        """
        continent = self.create_custom_continent()
        self.finalize_continent(continent)
        
        # Ask if the user wants to create another continent
        while True:
            another = input("Would you like to create another continent? (yes/no): ").strip().lower()
            if another == 'yes':
                continent = self.create_custom_continent()
                self.finalize_continent(continent)
            elif another == 'no':
                print("Thank you for using the Custom Continent Creator!")
                break
            else:
                print("Invalid input. Please enter 'yes' or 'no'.")

# Usage example:
if __name__ == "__main__":
    solo_game = SoloGame()  # Assume this initializes a new solo game
    creator = CustomContinentCreator(solo_game)
    creator.run()
