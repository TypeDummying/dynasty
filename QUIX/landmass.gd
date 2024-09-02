
extends Node

class_name LandmassCalculator

# Constants
const MIN_LANDMASS = 100  # Minimum landmass size in square kilometers
const MAX_LANDMASS = 1000000  # Maximum landmass size in square kilometers
const WATER_DENSITY = 1000  # kg/m^3
const EARTH_RADIUS = 6371  # km

# Variables
var country_name: String
var total_area: float
var land_area: float
var water_area: float
var coastline_length: float
var highest_point: float
var lowest_point: float
var average_elevation: float
var climate_zones: Dictionary
var natural_resources: Array
var terrain_types: Dictionary

# Initialize the LandmassCalculator
func _init():
    randomize()
    _generate_default_values()

# Generate default values for the country
func _generate_default_values():
    total_area = rand_range(MIN_LANDMASS, MAX_LANDMASS)
    land_area = total_area * rand_range(0.7, 0.95)
    water_area = total_area - land_area
    coastline_length = sqrt(total_area) * rand_range(0.5, 2.0)
    highest_point = rand_range(1000, 8848)  # Mount Everest height
    lowest_point = rand_range(-100, 0)
    average_elevation = rand_range(200, 1000)
    _generate_climate_zones()
    _generate_natural_resources()
    _generate_terrain_types()

# Generate climate zones for the country
func _generate_climate_zones():
    climate_zones = {
        "tropical": rand_range(0, 0.3),
        "subtropical": rand_range(0, 0.3),
        "temperate": rand_range(0, 0.3),
        "continental": rand_range(0, 0.3),
        "polar": rand_range(0, 0.1)
    }
    _normalize_dictionary(climate_zones)

# Generate natural resources for the country
func _generate_natural_resources():
    var possible_resources = [
        "oil", "natural gas", "coal", "iron ore", "copper",
        "gold", "silver", "uranium", "rare earth elements",
        "timber", "fish", "arable land"
    ]
    var num_resources = randi() % 5 + 3  # 3 to 7 resources
    natural_resources = []
    for i in range(num_resources):
        var resource = possible_resources[randi() % possible_resources.size()]
        if not resource in natural_resources:
            natural_resources.append(resource)

# Generate terrain types for the country
func _generate_terrain_types():
    terrain_types = {
        "plains": rand_range(0, 0.4),
        "mountains": rand_range(0, 0.3),
        "forests": rand_range(0, 0.3),
        "deserts": rand_range(0, 0.2),
        "tundra": rand_range(0, 0.1),
        "wetlands": rand_range(0, 0.1)
    }
    _normalize_dictionary(terrain_types)

# Normalize a dictionary so that all values sum to 1
func _normalize_dictionary(dict: Dictionary):
    var total = 0
    for value in dict.values():
        total += value
    for key in dict.keys():
        dict[key] /= total

# Set the country name
func set_country_name(name: String):
    country_name = name

# Calculate the volume of the landmass
func calculate_volume() -> float:
    return land_area * average_elevation

# Calculate the approximate weight of the landmass
func calculate_weight() -> float:
    var volume = calculate_volume()
    var density = 2700  # Average density of continental crust (kg/m^3)
    return volume * density * 1000000  # Convert km^3 to m^3

# Calculate the water volume
func calculate_water_volume() -> float:
    return water_area * 1000000  # Assume average depth of 1km and convert to m^3

# Calculate the water weight
func calculate_water_weight() -> float:
    return calculate_water_volume() * WATER_DENSITY

# Calculate the total weight of the country (land + water)
func calculate_total_weight() -> float:
    return calculate_weight() + calculate_water_weight()

# Calculate the surface area of the country as if it were a sphere
func calculate_surface_area_sphere() -> float:
    var radius = sqrt(total_area / (4 * PI))
    return 4 * PI * radius * radius

# Calculate the volume of the country as if it were a sphere
func calculate_volume_sphere() -> float:
    var radius = sqrt(total_area / (4 * PI))
    return (4/3) * PI * radius * radius * radius

# Calculate the gravitational force of the country
func calculate_gravity() -> float:
    var G = 6.67430e-11  # Gravitational constant
    var mass = calculate_total_weight()
    var radius = sqrt(total_area / (4 * PI))
    return (G * mass) / (radius * radius)

# Calculate the escape velocity of the country
func calculate_escape_velocity() -> float:
    var G = 6.67430e-11  # Gravitational constant
    var mass = calculate_total_weight()
    var radius = sqrt(total_area / (4 * PI))
    return sqrt((2 * G * mass) / radius)

# Calculate the country's share of Earth's surface
func calculate_earth_surface_share() -> float:
    var earth_surface = 4 * PI * EARTH_RADIUS * EARTH_RADIUS
    return total_area / earth_surface

# Generate a report of the country's landmass statistics
func generate_report() -> String:
    var report = "Landmass Report for %s\n" % country_name
    report += "================================\n"
    report += "Total Area: %.2f km²\n" % total_area
    report += "Land Area: %.2f km² (%.2f%%)\n" % [land_area, (land_area / total_area) * 100]
    report += "Water Area: %.2f km² (%.2f%%)\n" % [water_area, (water_area / total_area) * 100]
    report += "Coastline Length: %.2f km\n" % coastline_length
    report += "Highest Point: %.2f m\n" % highest_point
    report += "Lowest Point: %.2f m\n" % lowest_point
    report += "Average Elevation: %.2f m\n" % average_elevation
    report += "\nClimate Zones:\n"
    for zone in climate_zones:
        report += "  %s: %.2f%%\n" % [zone.capitalize(), climate_zones[zone] * 100]
    report += "\nNatural Resources:\n"
    for resource in natural_resources:
        report += "  - %s\n" % resource.capitalize()
    report += "\nTerrain Types:\n"
    for terrain in terrain_types:
        report += "  %s: %.2f%%\n" % [terrain.capitalize(), terrain_types[terrain] * 100]
    report += "\nAdvanced Calculations:\n"
    report += "Landmass Volume: %.2e km³\n" % calculate_volume()
    report += "Landmass Weight: %.2e kg\n" % calculate_weight()
    report += "Water Volume: %.2e m³\n" % calculate_water_volume()
    report += "Water Weight: %.2e kg\n" % calculate_water_weight()
    report += "Total Weight: %.2e kg\n" % calculate_total_weight()
    report += "Surface Area (if spherical): %.2f km²\n" % calculate_surface_area_sphere()"
    report += "Volume (if spherical): %.2e km³\n" % calculate_volume_sphere()
    report += "Gravitational Acceleration: %.2e m/s²\n" % calculate_gravity()
    report += "Escape Velocity: %.2f km/s\n" % (calculate_escape_velocity() / 1000)
    report += "Share of Earth's Surface: %.6f%%\n" % (calculate_earth_surface_share() * 100)
    return report

# Function to simulate natural disasters
func simulate_natural_disaster() -> Dictionary:
    var disaster_types = ["earthquake", "hurricane", "flood", "drought", "volcanic eruption"]
    var disaster = disaster_types[randi() % disaster_types.size()]
    var severity = rand_range(1, 10)
    var affected_area = rand_range(0, total_area * 0.1)  # Up to 10% of total area
    
    return {
        "type": disaster,
        "severity": severity,
        "affected_area": affected_area
    }

# Function to calculate population capacity based on landmass and resources
func calculate_population_capacity() -> int:
    var base_capacity = land_area * 100  # 100 people per km²
    var resource_multiplier = 1 + (natural_resources.size() * 0.1)  # 10% increase per resource
    var climate_multiplier = 1 + (climate_zones["temperate"] * 0.5)  # Up to 50% increase for temperate climate
    
    return int(base_capacity * resource_multiplier * climate_multiplier)

# Function to estimate economic potential based on landmass and resources
func estimate_economic_potential() -> float:
    var base_potential = land_area * 1000  # $1000 per km²
    var resource_multiplier = 1 + (natural_resources.size() * 0.2)  # 20% increase per resource
    var coastline_multiplier = 1 + (coastline_length / 1000 * 0.1)  # 10% increase per 1000km of coastline
    
    return base_potential * resource_multiplier * coastline_multiplier

# Function to calculate defense strength based on terrain and size
func calculate_defense_strength() -> float:
    var base_strength = sqrt(total_area)  # Base strength is square root of total area
    var terrain_multiplier = 1 + (terrain_types["mountains"] * 0.5) + (terrain_types["forests"] * 0.3)
    var coastline_factor = 1 - (coastline_length / (4 * sqrt(total_area)) * 0.2)  # Longer coastline reduces defense
    
    return base_strength * terrain_multiplier * coastline_factor

# Function to estimate food production capacity
func estimate_food_production() -> float:
    var arable_land = land_area * (terrain_types["plains"] + terrain_types["wetlands"])
    var base_production = arable_land * 1000  # 1000 tons per km² of arable land
    var climate_multiplier = 1 + (climate_zones["temperate"] * 0.3) + (climate_zones["tropical"] * 0.2)
    
    return base_production * climate_multiplier

# Function to calculate water security index
func calculate_water_security() -> float:
    var water_ratio = water_area / total_area
    var precipitation_factor = 1 + (climate_zones["tropical"] * 0.5) + (climate_zones["temperate"] * 0.3)
    var glacier_factor = 1 + (terrain_types["tundra"] * 0.2)
    
    return (water_ratio * precipitation_factor * glacier_factor) * 100  # Scale to 0-100

# Function to estimate renewable energy potential
func estimate_renewable_energy_potential() -> Dictionary:
    var solar_potential = (climate_zones["tropical"] + climate_zones["subtropical"]) * 1000
    var wind_potential = (terrain_types["plains"] + terrain_types["tundra"]) * 800
    var hydro_potential = (water_area / total_area) * 1200
    var geothermal_potential = terrain_types["mountains"] * 500
    
    return {
        "solar": solar_potential,
        "wind": wind_potential,
        "hydro": hydro_potential,
        "geothermal": geothermal_potential
    }

# Function to calculate biodiversity index
func calculate_biodiversity_index() -> float:
    var habitat_diversity = terrain_types.size()
    var climate_diversity = climate_zones.size()
    var resource_diversity = natural_resources.size()
    
    return (habitat_diversity * 0.4 + climate_diversity * 0.3 + resource_diversity * 0.3) * 10  # Scale to 0-100

# Function to estimate tourism potential
func estimate_tourism_potential() -> float:
    var natural_beauty = (terrain_types["mountains"] + terrain_types["forests"] + water_area / total_area) / 3
    var climate_appeal = climate_zones["tropical"] + climate_zones["subtropical"] + climate_zones["temperate"]
    var coastline_factor = coastline_length / sqrt(total_area)
    
    return (natural_beauty * 0.4 + climate_appeal * 0.3 + coastline_factor * 0.3) * 100  # Scale to 0-100

# Function to calculate diplomatic influence based on landmass characteristics
func calculate_diplomatic_influence() -> float:
    var size_factor = log(total_area) / log(MAX_LANDMASS)
    var resource_factor = natural_resources.size() / 10.0  # Assuming max 10 resources
    var strategic_location = coastline_length / sqrt(total_area)
    
    return (size_factor * 0.4 + resource_factor * 0.3 + strategic_location * 0.3) * 100  # Scale to 0-100

# Function to estimate technological development potential
func estimate_tech_development_potential() -> float:
    var education_capacity = calculate_population_capacity() * 0.2  # Assume 20% of population in education
    var resource_factor = 1 + (natural_resources.size() * 0.1)
    var economic_factor = log(estimate_economic_potential()) / log(1e12)  # Log scale, assuming 1 trillion as max
    
    return (education_capacity * economic_factor * resource_factor) / 1e6  # Scale down to a reasonable number

# Function to calculate environmental sustainability index
func calculate_environmental_sustainability() -> float:
    var forest_cover = terrain_types["forests"]
    var pollution_factor = 1 - (estimate_economic_potential() / 1e12)  # Assume larger economies pollute more
    var renewable_potential = estimate_renewable_energy_potential().values().sum() / 4000  # Normalize to 0-1
    
    return (forest_cover * 0.3 + pollution_factor * 0.3 + renewable_potential * 0.4) * 100  # Scale to 0-100

# Function to generate a comprehensive country profile
func generate_country_profile() -> String:
    var profile = "Comprehensive Country Profile for %s\n" % country_name
    profile += "==========================================\n\n"
    profile += "Geographic Overview:\n"
    profile += "--------------------\n"
    profile += "Total Area: %.2f km²\n" % total_area
    profile += "Land Area: %.2f km² (%.2f%%)\n" % [land_area, (land_area / total_area) * 100]
    profile += "Water Area: %.2f km² (%.2f%%)\n" % [water_area, (water_area / total_area) * 100]
    profile += "Coastline Length: %.2f km\n" % coastline_length
    profile += "Highest Point: %.2f m\n" % highest_point
    profile += "Lowest Point: %.2f m\n" % lowest_point