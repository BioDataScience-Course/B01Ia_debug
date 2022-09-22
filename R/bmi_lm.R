# Regression linéaire de IMC ~ age

# Packages ------
SciViews::R("model", lang = "fr"

# Importation des données ----------
bio <- read("biometry", pacakge = "BioDataScience")

# Exploration des données -------
skimr::skimr(bio)

## Graphiques
chart(data = bio, height ~ age) |>
  geom_point()

chart(data = bio, weight ~ age)
  geom_point()

# Calcul de la variable `bmi` ------
bio <- mutate(bio,
  bmi = labelise(weight/(height*100)^2, label = "IMC", units = "kg/m^2"),
  bmi_class = factor(
    case_when(
      bmi < 16 ~ "Underweight (Severe thinness)"
      bmi >= 16 & bmi < 17 ~ "Underweight (Moderate thinness)",
      bmi >= 17 & bmi < 18.5 ~ "Underweight (Mild thinness)",
      bmi >= 18.5 & bmi < 25 ~ "Normal range",
      bmi >= 25.0 & bmi < 30 ~ "Overweight (Pre-obese)",
      bmi >= 30 & bmi < 35 ~ "Obese (Class I)",
      bmi >= 35 & bmi < 40 ~ "Obese (Class II)",
      bmi >= 40 ~ "Obese (Class III)"
      ),
    levels = c(
      "Underweight (Severe thinness)", "Underweight (Moderate thinness)", "Underweight (Mild thinness)",
      "Normal range", "Overweight (Pre-obese)", "Obese (Class I)",
      "Obese (Class II)", "Obese (Class III)"
      ), ordered = TRUE)
  )

## Graphique
pbmi <- chart(data = bio, bmi ~ age) +
  geom_point()
pbmi

## Tableau
table(biometry$bmi_class)

bio %>.%
  sgroup_by(bmi_class, gender) |> summarise(.,
    bmi_mean = fmean(bmi), bmi_sd = fsd(bmi), n = fn(bmi)) ->
  bio_sum

bio_sum

# Modéliser la régression linéaire de  bmi ~ age ------
bmi_lm <- lm(data = bio, bmi ~ age)

## Résumé du modèle
summary(bio)
glance()
tidy(bio)

## Graphique du modèle
chart()

## Analyse des résidus
?chart.lm

### Distribution homogène des résidus
chart$(bmi_lm)

### Normalité des résidus
chart$(bmi_lm)

### Distribution des résidus standardisés
chart$(bim_lm)

### Influence des individus sur la régression linéaire
chart$(bmi_lm)

# Sauvegarde des objets importants `imc_lm`-----
bmi_result <- list(
  pbmi, bio_sum, bmi_lm
)

fs::dir_create("data/")
saveRDS(bmi_result, "data/bmi_lm.rds")
