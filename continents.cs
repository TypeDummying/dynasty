
using System;
using System.Collections.Generic;

namespace DynastyGeoGame
{
    /// <summary>
    /// Represents a continent on Earth for the Dynasty Geo Politics game.
    /// </summary>
    public class Continent
    {
        /// <summary>
        /// Gets or sets the name of the continent.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the total area of the continent in square kilometers.
        /// </summary>
        public double AreaInSquareKm { get; set; }

        /// <summary>
        /// Gets or sets the estimated population of the continent.
        /// </summary>
        public long Population { get; set; }

        /// <summary>
        /// Gets or sets the number of countries in the continent.
        /// </summary>
        public int NumberOfCountries { get; set; }

        /// <summary>
        /// Gets or sets the largest country in the continent by area.
        /// </summary>
        public string LargestCountry { get; set; }

        /// <summary>
        /// Gets or sets the most populous city in the continent.
        /// </summary>
        public string MostPopulousCity { get; set; }

        /// <summary>
        /// Gets or sets the primary languages spoken in the continent.
        /// </summary>
        public List<string> PrimaryLanguages { get; set; }

        /// <summary>
        /// Gets or sets the major climate zones found in the continent.
        /// </summary>
        public List<string> MajorClimateZones { get; set; }

        /// <summary>
        /// Gets or sets the highest point (mountain) in the continent.
        /// </summary>
        public string HighestPoint { get; set; }

        /// <summary>
        /// Gets or sets the lowest point in the continent.
        /// </summary>
        public string LowestPoint { get; set; }

        /// <summary>
        /// Gets or sets the major natural resources found in the continent.
        /// </summary>
        public List<string> MajorNaturalResources { get; set; }

        /// <summary>
        /// Initializes a new instance of the Continent class.
        /// </summary>
        /// <param name="name">The name of the continent.</param>
        /// <param name="areaInSquareKm">The total area of the continent in square kilometers.</param>
        /// <param name="population">The estimated population of the continent.</param>
        /// <param name="numberOfCountries">The number of countries in the continent.</param>
        /// <param name="largestCountry">The largest country in the continent by area.</param>
        /// <param name="mostPopulousCity">The most populous city in the continent.</param>
        public Continent(string name, double areaInSquareKm, long population, int numberOfCountries, string largestCountry, string mostPopulousCity)
        {
            Name = name;
            AreaInSquareKm = areaInSquareKm;
            Population = population;
            NumberOfCountries = numberOfCountries;
            LargestCountry = largestCountry;
            MostPopulousCity = mostPopulousCity;
            PrimaryLanguages = new List<string>();
            MajorClimateZones = new List<string>();
            MajorNaturalResources = new List<string>();
        }

        /// <summary>
        /// Adds a primary language to the continent.
        /// </summary>
        /// <param name="language">The language to add.</param>
        public void AddPrimaryLanguage(string language)
        {
            PrimaryLanguages.Add(language);
        }

        /// <summary>
        /// Adds a major climate zone to the continent.
        /// </summary>
        /// <param name="climateZone">The climate zone to add.</param>
        public void AddMajorClimateZone(string climateZone)
        {
            MajorClimateZones.Add(climateZone);
        }

        /// <summary>
        /// Adds a major natural resource to the continent.
        /// </summary>
        /// <param name="resource">The natural resource to add.</param>
        public void AddMajorNaturalResource(string resource)
        {
            MajorNaturalResources.Add(resource);
        }

        /// <summary>
        /// Sets the highest point (mountain) in the continent.
        /// </summary>
        /// <param name="highestPoint">The name of the highest point.</param>
        public void SetHighestPoint(string highestPoint)
        {
            HighestPoint = highestPoint;
        }

        /// <summary>
        /// Sets the lowest point in the continent.
        /// </summary>
        /// <param name="lowestPoint">The name of the lowest point.</param>
        public void SetLowestPoint(string lowestPoint)
        {
            LowestPoint = lowestPoint;
        }
    }

    /// <summary>
    /// Represents a collection of all continents on Earth for the Dynasty Geo Politics game.
    /// </summary>
    public static class Continents
    {
        /// <summary>
        /// Gets the list of all continents on Earth.
        /// </summary>
        public static List<Continent> AllContinents { get; private set; }

        /// <summary>
        /// Initializes the Continents class and populates the list of continents.
        /// </summary>
        static Continents()
        {
            AllContinents = new List<Continent>();
            InitializeContinents();
        }

        /// <summary>
        /// Initializes and populates the list of continents with detailed information.
        /// </summary>
        private static void InitializeContinents()
        {
            // Africa
            Continent africa = new Continent("Africa", 30370000, 1340598147, 54, "Algeria", "Cairo");
            africa.AddPrimaryLanguage("Arabic");
            africa.AddPrimaryLanguage("Swahili");
            africa.AddPrimaryLanguage("English");
            africa.AddPrimaryLanguage("French");
            africa.AddMajorClimateZone("Tropical");
            africa.AddMajorClimateZone("Subtropical");
            africa.AddMajorClimateZone("Desert");
            africa.AddMajorNaturalResource("Oil");
            africa.AddMajorNaturalResource("Diamonds");
            africa.AddMajorNaturalResource("Gold");
            africa.SetHighestPoint("Mount Kilimanjaro");
            africa.SetLowestPoint("Lake Assal");
            AllContinents.Add(africa);

            // Asia
            Continent asia = new Continent("Asia", 44579000, 4641054775, 49, "Russia", "Tokyo");
            asia.AddPrimaryLanguage("Mandarin Chinese");
            asia.AddPrimaryLanguage("Hindi");
            asia.AddPrimaryLanguage("Arabic");
            asia.AddPrimaryLanguage("Russian");
            asia.AddMajorClimateZone("Tropical");
            asia.AddMajorClimateZone("Subtropical");
            asia.AddMajorClimateZone("Temperate");
            asia.AddMajorClimateZone("Subarctic");
            asia.AddMajorNaturalResource("Oil");
            asia.AddMajorNaturalResource("Natural Gas");
            asia.AddMajorNaturalResource("Coal");
            asia.SetHighestPoint("Mount Everest");
            asia.SetLowestPoint("Dead Sea");
            AllContinents.Add(asia);

            // Europe
            Continent europe = new Continent("Europe", 10180000, 747636026, 44, "Russia", "Istanbul");
            europe.AddPrimaryLanguage("English");
            europe.AddPrimaryLanguage("German");
            europe.AddPrimaryLanguage("French");
            europe.AddPrimaryLanguage("Russian");
            europe.AddMajorClimateZone("Temperate");
            europe.AddMajorClimateZone("Mediterranean");
            europe.AddMajorClimateZone("Subarctic");
            europe.AddMajorNaturalResource("Coal");
            europe.AddMajorNaturalResource("Iron Ore");
            europe.AddMajorNaturalResource("Natural Gas");
            europe.SetHighestPoint("Mount Elbrus");
            europe.SetLowestPoint("Caspian Sea");
            AllContinents.Add(europe);

            // North America
            Continent northAmerica = new Continent("North America", 24709000, 592072212, 23, "Canada", "Mexico City");
            northAmerica.AddPrimaryLanguage("English");
            northAmerica.AddPrimaryLanguage("Spanish");
            northAmerica.AddPrimaryLanguage("French");
            northAmerica.AddMajorClimateZone("Arctic");
            northAmerica.AddMajorClimateZone("Subarctic");
            northAmerica.AddMajorClimateZone("Temperate");
            northAmerica.AddMajorClimateZone("Subtropical");
            northAmerica.AddMajorClimateZone("Tropical");
            northAmerica.AddMajorNaturalResource("Oil");
            northAmerica.AddMajorNaturalResource("Natural Gas");
            northAmerica.AddMajorNaturalResource("Timber");
            northAmerica.SetHighestPoint("Denali");
            northAmerica.SetLowestPoint("Death Valley");
            AllContinents.Add(northAmerica);

            // South America
            Continent southAmerica = new Continent("South America", 17840000, 430759766, 12, "Brazil", "São Paulo");
            southAmerica.AddPrimaryLanguage("Spanish");
            southAmerica.AddPrimaryLanguage("Portuguese");
            southAmerica.AddMajorClimateZone("Tropical");
            southAmerica.AddMajorClimateZone("Subtropical");
            southAmerica.AddMajorClimateZone("Temperate");
            southAmerica.AddMajorNaturalResource("Oil");
            southAmerica.AddMajorNaturalResource("Copper");
            southAmerica.AddMajorNaturalResource("Iron Ore");
            southAmerica.SetHighestPoint("Aconcagua");
            southAmerica.SetLowestPoint("Laguna del Carbón");
            AllContinents.Add(southAmerica);

            // Australia (Oceania)
            Continent australia = new Continent("Australia (Oceania)", 8600000, 43111704, 14, "Australia", "Sydney");
            australia.AddPrimaryLanguage("English");
            australia.AddPrimaryLanguage("Indonesian");
            australia.AddPrimaryLanguage("Tok Pisin");
            australia.AddMajorClimateZone("Arid");
            australia.AddMajorClimateZone("Tropical");
            australia.AddMajorClimateZone("Subtropical");
            australia.AddMajorClimateZone("Temperate");
            australia.AddMajorNaturalResource("Coal");
            australia.AddMajorNaturalResource("Iron Ore");
            australia.AddMajorNaturalResource("Gold");
            australia.SetHighestPoint("Puncak Jaya");
            australia.SetLowestPoint("Lake Eyre");
            AllContinents.Add(australia);

            // Antarctica
            Continent antarctica = new Continent("Antarctica", 14200000, 1106, 0, "N/A", "N/A");
            antarctica.AddMajorClimateZone("Polar");
            antarctica.AddMajorNaturalResource("Ice");
            antarctica.AddMajorNaturalResource("Coal");
            antarctica.AddMajorNaturalResource("Oil");
            antarctica.SetHighestPoint("Vinson Massif");
            antarctica.SetLowestPoint("Bentley Subglacial Trench");
            AllContinents.Add(antarctica);
        }

        /// <summary>
        /// Retrieves a continent by its name.
        /// </summary>
        /// <param name="name">The name of the continent to retrieve.</param>
        /// <returns>The Continent object if found, otherwise null.</returns>
        public static Continent GetContinentByName(string name)
        {
            return AllContinents.Find(c => c.Name.Equals(name, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Retrieves the continent with the largest area.
        /// </summary>
        /// <returns>The Continent object with the largest area.</returns>
        public static Continent GetLargestContinent()
        {
            return AllContinents.OrderByDescending(c => c.AreaInSquareKm).First();
        }

        /// <summary>
        /// Retrieves the continent with the smallest area.
        /// </summary>
        /// <returns>The Continent object with the smallest area.</returns>
        public static Continent GetSmallestContinent()
        {
            return AllContinents.OrderBy(c => c.AreaInSquareKm).First();
        }

        /// <summary>
        /// Retrieves the continent with the largest population.
        /// </summary>
        /// <returns>The Continent object with the largest population.</returns>
        public static Continent GetMostPopulousContinent()
        {
            return AllContinents.OrderByDescending(c => c.Population).First();
        }

        /// <summary>
        /// Retrieves the continent with the smallest population.
        /// </summary>
        /// <returns>The Continent object with the smallest population.</returns>
        public static Continent GetLeastPopulousContinent()
        {
            return AllContinents.OrderBy(c => c.Population).First();
        }

        /// <summary>
        /// Calculates the total world population based on the sum of all continent populations.
        /// </summary>
        /// <returns>The total world population.</returns>
        public static long GetTotalWorldPopulation()
        {
            return AllContinents.Sum(c => c.Population);
        }

        /// <summary>
        /// Calculates the total land area of the Earth based on the sum of all continent areas.
        /// </summary>
        /// <returns>The total land area of the Earth in square kilometers.</returns>
        public static double GetTotalLandArea()
        {
            return AllContinents.Sum(c => c.AreaInSquareKm);
        }

        /// <summary>
        /// Retrieves a list of all continents sorted by area in descending order.
        /// </summary>
        /// <returns>A list of Continent objects sorted by area.</returns>
        public static List<Continent> GetContinentsSortedByArea()
        {
            return AllContinents.OrderByDescending(c => c.AreaInSquareKm).ToList();
        }

        /// <summary>
        /// Retrieves a list of all continents sorted by population in descending order.
        /// </summary>
        /// <returns>A list of Continent objects sorted by population.</returns>
        public static List<Continent> GetContinentsSortedByPopulation()
        {
            return AllContinents.OrderByDescending(c => c.Population).ToList();
        }

        /// <summary>
        /// Retrieves a list of all continents that have a specific climate zone.
        /// </summary>
        /// <param name="climateZone">The climate zone to search for.</param>
        /// <returns>A list of Continent objects that have the specified climate zone.</returns>
        public static List<Continent> GetContinentsByClimateZone(string climateZone)
        {
            return AllContinents.Where(c => c.MajorClimateZones.Contains(climateZone))
        }
    }
}
