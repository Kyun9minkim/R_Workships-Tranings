
library(tidyverse)
library(tidyr)
library(dplyr)

setwd("C:/Users/kyungmi1/Documents/Code/R_Workships&Tranings")


counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20, 25, 30),
  fox = c(4, 4, 4)
)

counts_df

counts_df <- pivot_longer(counts_df, !day, names_to = "species", values_to = "count")

counts_df

counts_df <- pivot_wider(counts_df, names_from = "species", values_from = "count")

counts_df

---------------------------------------------------------------------------------------

species <- read.csv("species.csv", na.strings = "")
surveys <- read.csv("surveys.csv", na.strings = "")

head(species)

species <- unite(species, name, c(genus, species), sep=" ")

head(species)

species <- separate(species, name, c("genus", "species"), sep=" ", convert = TRUE)

head(species)

head(surveys)

surveys <- unite(surveys, date, c(year, month, day), sep="/", remove = FALSE)
head(surveys)

---------------------------------------------------------------------------------------
  
  
surveys_pick100 <- sample_n(surveys, 100)
head(surveys_pick100)
sorted1 <- arrange(surveys_pick100, species, desc(wgt))
head(sorted1)

sorted2 <- surveys_pick100[order(surveys_pick100$species, -surveys_pick100$wgt), ]
head(sorted2)

survey1990_winter <- filter(surveys, year == 1990, month %in% 1:3)
head(survey1990_winter)

survey1990_winter <- select(survey1990_winter, -year)
head(survey1990_winter)

survey1990_winter <- group_by(survey1990_winter, species)
head(survey1990_winter)

counts_1990w <- summarise(survey1990_winter, count = n())
head(counts_1990w)


---------------------------------------------------------------------------------------
  
  
counts_1990w_join <- inner_join(counts_1990w, species,
                                by = c("species" = "species_id"))
head(counts_1990w_join)

counts_1990w <- mutate(counts_1990w, prop = count / sum(count))

head(counts_1990w)
