
using System;
using System.Collections.Generic;

namespace GeoPoliticsGame
{
    /// <summary>
    /// Represents the main countries of the world for the geo-politics game dynasty.
    /// </summary>
    public static class MainCountries
    {
        /// <summary>
        /// Represents a country in the game.
        /// </summary>
        public class Country
        {
            public string Name { get; set; }
            public string Capital { get; set; }
            public string Continent { get; set; }
            public double Area { get; set; } // in square kilometers
            public long Population { get; set; }
            public string Government { get; set; }
            public string Currency { get; set; }
            public List<string> Languages { get; set; }
            public List<string> BorderingCountries { get; set; }
            public double GDP { get; set; } // in billions of USD
            public int MilitaryStrength { get; set; } // scale of 1-100
            public int DiplomaticInfluence { get; set; } // scale of 1-100
            public int TechnologyLevel { get; set; } // scale of 1-100
            public int NaturalResources { get; set; } // scale of 1-100

            public Country(string name, string capital, string continent, double area, long population,
                           string government, string currency, List<string> languages, List<string> borderingCountries,
                           double gdp, int militaryStrength, int diplomaticInfluence, int technologyLevel, int naturalResources)
            {
                Name = name;
                Capital = capital;
                Continent = continent;
                Area = area;
                Population = population;
                Government = government;
                Currency = currency;
                Languages = languages;
                BorderingCountries = borderingCountries;
                GDP = gdp;
                MilitaryStrength = militaryStrength;
                DiplomaticInfluence = diplomaticInfluence;
                TechnologyLevel = technologyLevel;
                NaturalResources = naturalResources;
            }
        }

        /// <summary>
        /// List of all countries in the game.
        /// </summary>
        public static List<Country> Countries { get; private set; }

        /// <summary>
        /// Initializes the list of main countries.
        /// </summary>
        static MainCountries()
        {
            Countries = new List<Country>();
            InitializeCountries();
        }

        /// <summary>
        /// Populates the Countries list with all main countries.
        /// </summary>
        private static void InitializeCountries()
        {
            // United States
            Countries.Add(new Country(
                "United States",
                "Washington, D.C.",
                "North America",
                9833517,
                331002651,
                "Federal Presidential Constitutional Republic",
                "United States Dollar",
                new List<string> { "English" },
                new List<string> { "Canada", "Mexico" },
                21433.23,
                100,
                95,
                100,
                85
            ));

            // China
            Countries.Add(new Country(
                "China",
                "Beijing",
                "Asia",
                9596961,
                1439323776,
                "Unitary One-Party Socialist Republic",
                "Renminbi (Yuan)",
                new List<string> { "Mandarin Chinese" },
                new List<string> { "Russia", "Mongolia", "North Korea", "Vietnam", "Laos", "Myanmar", "India", "Bhutan", "Nepal", "Pakistan", "Afghanistan", "Tajikistan", "Kyrgyzstan", "Kazakhstan" },
                14342.90,
                98,
                90,
                95,
                80
            ));

            // Russia
            Countries.Add(new Country(
                "Russia",
                "Moscow",
                "Europe/Asia",
                17098246,
                145934462,
                "Federal Semi-Presidential Constitutional Republic",
                "Russian Ruble",
                new List<string> { "Russian" },
                new List<string> { "Norway", "Finland", "Estonia", "Latvia", "Lithuania", "Poland", "Belarus", "Ukraine", "Georgia", "Azerbaijan", "Kazakhstan", "China", "Mongolia", "North Korea" },
                1699.88,
                95,
                85,
                90,
                100
            ));

            // Germany
            Countries.Add(new Country(
                "Germany",
                "Berlin",
                "Europe",
                357022,
                83783942,
                "Federal Parliamentary Republic",
                "Euro",
                new List<string> { "German" },
                new List<string> { "Denmark", "Poland", "Czech Republic", "Austria", "Switzerland", "France", "Luxembourg", "Belgium", "Netherlands" },
                3846.89,
                80,
                92,
                95,
                60
            ));

            // United Kingdom
            Countries.Add(new Country(
                "United Kingdom",
                "London",
                "Europe",
                242495,
                67886011,
                "Unitary Parliamentary Constitutional Monarchy",
                "Pound Sterling",
                new List<string> { "English" },
                new List<string> { "Ireland" },
                2827.11,
                85,
                90,
                92,
                65
            ));

            // Add more countries...

            // Zimbabwe (adding this as the last country for diversity)
            Countries.Add(new Country(
                "Zimbabwe",
                "Harare",
                "Africa",
                390757,
                14862924,
                "Presidential Republic",
                "RTGS Dollar",
                new List<string> { "English", "Shona", "Ndebele" },
                new List<string> { "Zambia", "Mozambique", "South Africa", "Botswana" },
                19.27,
                40,
                30,
                35,
                70
            ));
        }

        /// <summary>
        /// Retrieves a country by its name.
        /// </summary>
        /// <param name="name">The name of the country to retrieve.</param>
        /// <returns>The Country object if found, null otherwise.</returns>
        public static Country GetCountryByName(string name)
        {
            return Countries.Find(c => c.Name.Equals(name, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Retrieves all countries in a specific continent.
        /// </summary>
        /// <param name="continent">The name of the continent.</param>
        /// <returns>A list of countries in the specified continent.</returns>
        public static List<Country> GetCountriesByContinent(string continent)
        {
            return Countries.FindAll(c => c.Continent.Equals(continent, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Calculates the total world population based on all countries.
        /// </summary>
        /// <returns>The total world population.</returns>
        public static long CalculateWorldPopulation()
        {
            return Countries.Sum(c => c.Population);
        }

        /// <summary>
        /// Finds the country with the highest GDP.
        /// </summary>
        /// <returns>The country with the highest GDP.</returns>
        public static Country GetHighestGDPCountry()
        {
            return Countries.OrderByDescending(c => c.GDP).First();
        }

        /// <summary>
        /// Finds the country with the largest area.
        /// </summary>
        /// <returns>The country with the largest area.</returns>
        public static Country GetLargestCountryByArea()
        {
            return Countries.OrderByDescending(c => c.Area).First();
        }

        /// <summary>
        /// Calculates the average military strength of all countries.
        /// </summary>
        /// <returns>The average military strength.</returns>
        public static double CalculateAverageMilitaryStrength()
        {
            return Countries.Average(c => c.MilitaryStrength);
        }

        /// <summary>
        /// Finds countries that border a specific country.
        /// </summary>
        /// <param name="countryName">The name of the country to find borders for.</param>
        /// <returns>A list of countries that border the specified country.</returns>
        public static List<Country> GetBorderingCountries(string countryName)
        {
            var country = GetCountryByName(countryName);
            if (country == null) return new List<Country>();

            return Countries.Where(c => country.BorderingCountries.Contains(c.Name)).ToList();
        }

        /// <summary>
        /// Calculates the total land area of all countries.
        /// </summary>
        /// <returns>The total land area in square kilometers.</returns>
        public static double CalculateTotalLandArea()
        {
            return Countries.Sum(c => c.Area);
        }

        /// <summary>
        /// Finds countries with a specific government type.
        /// </summary>
        /// <param name="governmentType">The type of government to search for.</param>
        /// <returns>A list of countries with the specified government type.</returns>
        public static List<Country> GetCountriesByGovernmentType(string governmentType)
        {
            return Countries.Where(c => c.Government.Contains(governmentType, StringComparison.OrdinalIgnoreCase)).ToList();
        }

        /// <summary>
        /// Calculates the average technological level of all countries.
        /// </summary>
        /// <returns>The average technological level.</returns>
        public static double CalculateAverageTechnologyLevel()
        {
            return Countries.Average(c => c.TechnologyLevel);
        }

        /// <summary>
        /// Finds the country with the highest diplomatic influence.
        /// </summary>
        /// <returns>The country with the highest diplomatic influence.</returns>
        public static Country GetMostInfluentialCountry()
        {
            return Countries.OrderByDescending(c => c.DiplomaticInfluence).First();
        }

        /// <summary>
        /// Calculates the total GDP of all countries.
        /// </summary>
        /// <returns>The total GDP in billions of USD.</returns>
        public static double CalculateTotalWorldGDP()
        {
            return Countries.Sum(c => c.GDP);
        }

        /// <summary>
        /// Finds countries with a population above a certain threshold.
        /// </summary>
        /// <param name="threshold">The population threshold.</param>
        /// <returns>A list of countries with population above the specified threshold.</returns>
        public static List<Country> GetHighPopulationCountries(long threshold)
        {
            return Countries.Where(c => c.Population > threshold).ToList();
        }

        /// <summary>
        /// Finds the country with the most natural resources.
        /// </summary>
        /// <returns>The country with the highest natural resources score.</returns>
        public static Country GetMostResourceRichCountry()
        {
            return Countries.OrderByDescending(c => c.NaturalResources).First();
        }

        /// <summary>
        /// Calculates the average GDP per capita for all countries.
        /// </summary>
        /// <returns>The average GDP per capita in USD.</returns>
        public static double CalculateAverageGDPPerCapita()
        {
            return Countries.Average(c => (c.GDP * 1000000000) / c.Population);
        }

        /// <summary>
        /// Finds countries that use a specific currency.
        /// </summary>
        /// <param name="currency">The currency to search for.</param>
        /// <returns>A list of countries using the specified currency.</returns>
        public static List<Country> GetCountriesByCurrency(string currency)
        {
            return Countries.Where(c => c.Currency.Equals(currency, StringComparison.OrdinalIgnoreCase)).ToList();
        }

        /// <summary>
        /// Calculates the total military strength of all countries.
        /// </summary>
        /// <returns>The sum of all countries' military strength scores.</returns>
        public static int CalculateTotalMilitaryStrength()
        {
            return Countries.Sum(c => c.MilitaryStrength);
        }

        /// <summary>
        /// Finds countries with multiple official languages.
        /// </summary>
        /// <returns>A list of countries with more than one official language.</returns>
        public static List<Country> GetMultilingualCountries()
        {
            return Countries.Where(c => c.Languages.Count > 1).ToList();
        }

        /// <summary>
        /// Calculates the average area of countries in a specific continent.
        /// </summary>
        /// <param name="continent">The name of the continent.</param>
        /// <returns>The average area of countries in the specified continent.</returns>
        public static double CalculateAverageAreaByContinent(string continent)
        {
            var continentCountries = GetCountriesByContinent(continent);
            return continentCountries.Any() ? continentCountries.Average(c => c.Area) : 0;
        }

        /// <summary>
        /// Finds the country with the most bordering countries.
        /// </summary>
        /// <returns>The country that borders the most other countries.</returns>
        public static Country GetCountryWithMostBorders()
        {
            return Countries.OrderByDescending(c => c.BorderingCountries.Count).First();
        }

        // Additional methods and game logic can be added here...
    }
}
