# Build the coding_data_clean.RDS dataset from the published Table 2
# of Leith, Ratan, & Wohn (2016).
#
# Run: Rscript build-data.R
# This file may be safely deleted after the .RDS exists; it's kept here
# so the dataset is reproducible.

games <- data.frame(
  game_title = c(
    # Study 1 — Commercial games (n=14, in alphabetical order from Table 2)
    "Creatures",
    "E.V.O.: Search for Eden",
    "Eco",
    "Evolush: Evolution Journey",
    "Evolution",
    "Evolution HD",
    "Evolution: The Game of Intelligent Life",
    "L.O.L.: Lack of Love",
    "Pride of the Dragon Peace",
    "Seventh Cross Evolution",
    "Shootanto: Evolutionary Mayhem!",
    "SimEarth",
    "SimLife",
    "Spore",
    # Study 2 — Academic / educational games (n=8)
    "Angry Aliens: Evolution",
    "DNA Roulette",
    "Life Preservers",
    "NERO",
    "Seed",
    "Selection Game",
    "Variation Game",
    "Who Wants to Live a Million Years"
  ),
  game_origin = c(
    rep("Commercial", 14),
    rep("Academic", 8)
  ),
  source_database = c(
    rep("Game Database", 14),
    "Google Search",
    "Personal Network",
    "Personal Network",
    "Personal Network",
    "Google Search",
    "Personal Network",
    "Personal Network",
    "Google Search"
  ),
  phenotypic_variation = c(
    "Yes", "Yes", "Yes", "Yes",
    "Yes", "Yes", "Yes",
    "Yes", "Yes", "Yes",
    "Yes", "Yes", "Yes", "Yes",
    "No", "Yes", "No", "Yes",
    "Yes", "Yes", "Yes", "Yes"
  ),
  differential_fitness = c(
    "Yes", "No", "No", "No",
    "No", "No", "No",
    "No", "No", "No",
    "No", "Yes", "Yes", "No",
    "No", "No", "No", "Yes",
    "No", "Yes", "No", "Yes"
  ),
  fitness_heritability = c(
    "Yes", "No", "Yes", "No",
    "No", "No", "Yes",
    "No", "No", "No",
    "No", "Yes", "Yes", "Yes",
    "No", "No", "No", "No",
    "Yes", "Yes", "No", "Yes"
  ),
  stringsAsFactors = FALSE
)

# Derive principle count
games$principles_count <- (games$phenotypic_variation == "Yes") +
                          (games$differential_fitness == "Yes") +
                          (games$fitness_heritability == "Yes")

# Derive ENS completeness as 3-level categorical (var1 in the template)
games$ens_completeness <- ifelse(
  games$principles_count == 0, "None",
  ifelse(games$principles_count == 3, "Complete", "Partial")
)

# Convert categorical columns to factors
games$game_origin <- factor(games$game_origin, levels = c("Commercial", "Academic"))
games$ens_completeness <- factor(games$ens_completeness, levels = c("None", "Partial", "Complete"))
games$source_database <- factor(games$source_database)

# Sanity print
cat("N =", nrow(games), "\n")
cat("By origin:\n"); print(table(games$game_origin))
cat("By completeness:\n"); print(table(games$ens_completeness))
cat("Cross-tab:\n"); print(table(games$ens_completeness, games$game_origin))

saveRDS(games, "coding_data_clean.RDS")
cat("\nSaved coding_data_clean.RDS\n")
