# Régression linéaire de IMC ~ circonférence du poignet
## Version 2
################################################################################

# Packages -------
SciViews::R("model" lang = "fr")

# Importation des données ----------
bio <- read("biometry", package = BioDataScience)
??biometry

# Exploration des données -------
skimr::skim(bio)

# Calcul de l'IMC (bmi, body mass index) et de l'indice de masse grasse (bfp, body fat percentage) -------
## IMC (kg/m^2)
## IMC = Masse/Taille^2
## Masse en kilogramme
## Taille en mètre
## IMG (%)
## IMG (%) = (1.20∗IMC) + (0.23∗Age) − (10.8∗Sexe) − 5.4
## Age en année
## Sexe : Sexe = 1 pour les hommes et Sexe = 0 pour les femmes
bio <- mutate(bio,
  bmi = labelise(weight^2/height, label = "IMC", units = "kg/m^2"),
  bfp = labelise(case_when(
    gender == "W" ~ (1.20*bmi) + (0.23*age) - 10.8 - 5.4
    gender == "W" ~ (1.20*bmi) + (0.23*age) - 5.4)
    , labels = "IMG", units = "%")
  )

## Corrélation entre les variables  weight, height,wrist, age, bmi, bfp -------
bio %>.%
  sselect(., c(weight, height, wirst, age, bmi, bfp)) %>.%
  sdrop_na(., wrist) %>.%
  correlation(.) ->
  bio_corr

plot(bio_cor, type = "upper")

## Tableau résumé -------
bio |>
  group_by(., gender) |> ssummarise(
    bfp_mean = fmean(bfp), bfp_sd = fsd(img),
    bmi_mean = fmean(bim), bmi_sd = fsd(bmi),
    n = fn(bfp)) ->
  bio_sum

bio_sum

## Graphiques -------
### Masse en fonction de la taille
pweight <- chart(data = bio,  ~ weight+height)
  geom_point()

### IMG en fonction du genre
pbfp <- chart(data = bio, bfp ~ gender) |>
  geom_boxplot()

### IMC en fonction de la circomférence du poignet
pbmi <- chart(data = bio, bmi ~ wrist) +
  geom_point()

### Graphiques combinés
combine_charts(list(pweight, pbfp, pbmi))

# Modéliser la régression linéaire de bmi ~ wrist ------
bmi_lm <- lm(bio, bmi ~ wrist)

## Résumé du modèle
glance(bmi_ml)
tidy(bio_lm)

# Page d'aide des graphiques
?chart.lm

## Graphique du modèle
chart(bmi_lm)

## Analyse des résidus
### Distribution homogène des résidus
chart$(bmi_lm)

### Normalité des résidus
chart$(bmi_lm)

### Distribution des résidus standardisés
chart$(bmi_lm)

### Influence des individus sur la régression linéaire
chart$(bmi_lm)

# Sauvegarde des objets importants `imc_lm`-----
bmi_result <- list(
  pbmi, bio_sum, bmi_lm
)

fs::dir_create("data/")
saveRDS(bmi_result, "data/bmi_lm.rds")
