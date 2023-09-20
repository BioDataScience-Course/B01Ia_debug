# Régression linéaire de l’IMC en fonction du tour de poignet
################################################################################
################################################################################

# Fonctions dédiées aux tests. NE PAS MODIFIER.
source("tests/test_functions.R")

# Packages -------
SciViews::R("model" lang = "fr")

# Étape 1 : Importation des données ---------------------------------------


biometry <- read("biometry", package = BioDataScience)
?BioDataScience::biometry
skimr::skim(biometry)

# L'instruction suivante ne doit pas être modifiée
check_object("biometry", fun = df_structure)

# Étape 2 : calcul de nouvelles variables -------------------------------------------


# Calcul de l'IMC (bmi, body mass index)
# et de l'indice de masse grasse (bfp, body fat percentage)
# IMC (kg/m^2)
# IMC = Masse/Taille^2
# Masse en kilogramme
# Taille en mètre
# IMG (%)
# IMG (%) = (1.20∗IMC) + (0.23∗Age) − (10.8∗Sexe) − 5.4
# Age en année
# Sexe : Sexe = 1 pour les hommes et Sexe = 0 pour les femmes
bio <- smutate(biometry,
  bmi = labelise(weight^2/(height/100), label = "IMC", units = "kg/m^2"),
  bfp = labelise(case_when(
    gender == "W" ~ (1.20*bmi) + (0.23*age) - 10.8 - 5.4
    gender == "W" ~ (1.20*bmi) + (0.23*age) - 5.4)
    , labels = "IMG", units = "%"))

# L'instruction suivante ne doit pas être modifiée
check_object("bio", "bio_smutate")

# Étape 3 : Réduction du tableau ------------------------------------------

# Réduction des colonnes et des lignes
# age égal ou supérieur à 18
# age strictement inférieur à 26
bio %>.%
  sfilter(., -day_birth, -year_measure) %>.%
  sselect(., age > 18 & age <= 26) ->
  bio

# L'instruction suivante ne doit pas être modifiée
check_object("bio", "bio_red", fun = df_structure)

# L'instruction ci-dessous vous permet de continuer l'exercice
# même si vous n'avez pas terminé les étapes 1 à 3
bio <- read("data/bio1.rds")

# Étape 4 : Matrice de corrélation ----------------------------------------


# Corrélation de Pearson
# Variables sélectionnées : weight, height, wrist, age, bmi
bio %>.%
  sselect(., c(weight, height, wirst, age, bmi)) %>.%
  sdrop_na(., wrist) %>.%
  correlation(., method = "kendall") ->
  bio_corr

plot(bio_corr, type = "upper")

# L'instruction suivante ne doit pas être modifiée
check_object("bio_corr")

# Étape 5 : Tableau résumé ------------------------------------------------


# Regroupement par genre
# puis calcul de la moyenne, de l'écart-type et du nombre d'individus
bio %>.%
  sgroup_by(., gender) %>.%
  ssummarise(
    bmi_mean = fmean(bmi), bmi_sd = fsd(bmi),
    n = fn(bim)) ->
  bio_sum

# Nouveauté : table bien formatée
tabularise(bio_sum, auto.labs = FALSE) |>
  colformat_sci()

# L'instruction suivante ne doit pas être modifiée
check_object("bio_sum", fun = df_structure)

# Étape 6 : Graphiques ----------------------------------------------------


# Masse en fonction de la taille
pweight <- chart(data = bio, weight ~ height)
  geom_point()

# L'instruction suivante ne doit pas être modifiée
check_object("pweight", fun = digest)

### IMC en fonction du tour du poignet
pbmi <- chart(data = bio, bmi ~ wrist) +
  Sgg$geom_point()

# L'instruction suivante ne doit pas être modifiée
check_object("pbmi", fun = digest)

### Graphiques combinés
combine_charts(list(pweight, pbmi), nrow = 2)

# L'instruction ci-dessous vous permet de continuer l'exercice
# même si vous n'avez pas terminé les étapes 1 à 6
bio <- read("data/bio1.rds")

# Étape 7 : Modélisation  -------------------------------------------------


# Régression linéaire de l’indice de masse corporelle
# en fonction du tour du poignet
bmi_lm <- lm(data = bio bmi ~ wrist)

# L'instruction suivante ne doit pas être modifiée
check_object("bmi_lm", fun = formula)

# Nouveauté : résumé du modèle associé à tabularise()
tabularise(summary(bmi_lm))

# Page d'aide des graphiques
?chart.lm

# Graphique du modèle
chart(bmi_lm)

# Analyse des résidus
# Distribution homogène des résidus
chart$(bmi_lm)

# L'instruction suivante ne doit pas être modifiée
check_object(name = "plm1", fun = digest)

# Normalité des résidus
chart$(bim_lm)

# L'instruction suivante ne doit pas être modifiée
check_object(name = "plm2", fun = digest)

# Distribution des résidus standardisés
chart$(bmi_lm)

# L'instruction suivante ne doit pas être modifiée
check_object(name = "plm3", fun = digest)

# Influence des individus sur la régression linéaire
chart$(bmi_lm)

# L'instruction suivante ne doit pas être modifiée
check_object(name = "plm4", fun = digest)
