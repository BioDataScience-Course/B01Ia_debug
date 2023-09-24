# Régression linéaire de l’IMC en fonction du tour de poignet

# Consigne générale : corrigez les lignes de code et exécutez-les dans l'ordre.
# Ne modifiez pas les codes en fin de ligne de style "; RODFS('biometry')" car
# ils servent aux tests. Il n'y a aucune erreur à corriger à leur niveau !
# Allez dans l'onglet Construire -> Construire tout pour lancer les tests

# Nécessaire pour les tests (exécutez avant toute chose) - pas d'erreur ici.
if (!"tools:tests" %in% search())
  source(here::here("tests/tools_tests.R"), attach(NULL, name = "tools:tests"))

# Configuration de l'environnement
SciViews::R("model" lang = "fr")


# Étape 1 : Importation des données ---------------------------------------

biometry <- read("biometry", package = BioDataScience); RODFS('biometry')
skimr::skim(biometry)


# Étape 2 : Calcul de nouvelles variables ----------------------------------

# Calcul de l'IMC (bmi, body mass index)
# et de l'indice de masse grasse (bfp, body fat percentage)
# IMC (kg/m^2) = Masse/Taille^2 (Masse en kg et Taille en m)
# IMG (%) = (1.20 ∗ IMC) + (0.23 ∗ Age) − (10.8 ∗ Sexe) − 5.4
# Age en années
# Sexe : Sexe = 1 pour les hommes et Sexe = 0 pour les femmes
bio1 <- smutate(biometry,
  bmi = labelise(weight^2 / (height/100), label = "IMC", units = "kg/m^2"),
  bfp = labelise(case_when(
    gender == "W" ~ (1.20 * bmi) + (0.23 * age) - 10.8 - 5.4
    gender == "W" ~ (1.20 * bmi) + (0.23 * age) - 5.4),
    labels = "IMG (%)", units = NA)); RODFS('bio1')


# Étape 3 : Réduction du tableau ------------------------------------------

# Élimination des colonnes day_birth et year_measure
# On garde age égal ou supérieur à 18 et age strictement inférieur à 26
bio1 %>.%
  sfilter(., -day_birth, -year_measure) %>.%
  sselect(., age > 18 & age <= 26) ->
  bio2; RODFS('bio2')


# Étape 4 : Matrice de corrélation ----------------------------------------

# Ceci permet de continuer l'exercice même sans avoir terminé les étapes 1 à 3
bio2 <- read("data/bio2.rds")

# Corrélation de Pearson, variables : weight, height, wrist, age, bmi
bio2 %>.%
  sselect(., weight, height, wirst, age, bmi) %>.%
  sdrop_na(., wrist) %>.%
  correlation(., method = "kendall") ->
  bio_corr; ROMD5('bio_corr')

plot(bio_corr, type = "upper")


# Étape 5 : Tableau résumé ------------------------------------------------

# Regroupement par genre
# puis calcul de la moyenne, de l'écart-type et du nombre d'individus
bio2 %>.%
  sgroup_by(., gender) %>.%
  ssummarise(
    bmi_mean = fmean(bmi),
    bmi_sd   = fsd(bmi),
    n        = fn(bim)) ->
  bio_summ; RODFS('bio_summ')

# Nouveauté : table bien formatée
tabularise(bio_summ, auto.labs = FALSE) |>
  colformat_sci()


# Étape 6 : Graphique de la masse en fonction de la taille -----------------

chart_weight <- chart(data = bio2, weight ~ height)
  geom_point(); ROSTR('chart_weight', part = 'mapping,layers')


# Étape 7 : Graphique de l'IMC en fonction du tour de poignet --------------

chart_bmi <- chart(data = bio2, bmi ~ wrist) +
  Sgg$geom_point(); ROSTR('chart_bmi', part = 'mapping,layers')

combine_charts(list(chart_weight, chart_bmi), ncol = 2)


# Étape 8 : Modélisation  -------------------------------------------------

# Ceci permet de continuer l'exercice même sans avoir terminé les étapes 1 à 7
bio2 <- read("data/bio2.rds")

# Régression linéaire : IMC en fonction du tour du poignet
bmi_lm <- lm(data = bio2 bmi ~ wrist); ROP('bmi_lm', part = 'call')

# Nouveauté : résumé du modèle mieux présenté grâce à tabularise()
tabularise(summary(bmi_lm))

# Graphique du modèle
chart(bmi_lm)


# Étape 9 : Analyse des résidus -------------------------------------------

# Indice : utilisez la page d'aide ?chart.lm pour vous guider

# A. Résidus en fonction des valeurs prédites
(resid1 <- chart$(bmi_lm)); ROP('resid1', part = 'labels')

# B. Normalité des résidus
(resid2 <- chart$(bim_lm)); ROP('resid2', part = 'labels')

# C. Homoscédasticité des résidus
(resid3 <- chart$(bmi_lm)); ROP('resid3', part = 'labels')

# D. Influence des individus sur la régression linéaire
# (levier, résidus et distance de Cook sur le même graphique)
(resid4 <- chart$(bmi_lm)); ROP('resid4', part = 'labels')

# Lorsque vous avez terminé l'exercice, et s'il reste du temps, vous pouvez
# tenter une analyse de la régression et des résidus en rajoutant en commentaire
# vos impressions ci-dessous.


