# Vérification de R/bmi_lm.R

test_that("
  Étape 1 : Importation des données", {

  expect_true(!is.null(read_res("biometry")))
  # Le jeu de données `biometry` est introuvable après l'étape 1.
  # Avez-vous corrigé les erreurs dans le code ?
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?
})

test_that("
  Étape 2 : Calcul de nouvelles variables", {
  res <- read_res("bio_smutate")
  tpl <- read_tpl("bio_smutate")

  expect_true(!is.null(res))
  # Le jeu de données `bio` est introuvable après l'étape 2
  # Vous n'avez peut-être pas corrigé toutes les erreurs dans le code ?
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(names(res), names(tpl))
  # Des colonnes sont manquantes ou ne portent pas le bon nom

  expect_lt(collapse::fmean(res$bmi), 50)
  # Les valeurs d'IMC sont trop élevées.
  # Par exemple, selon l’OMS, une personne est en obésité
  # quand son IMC est égal ou supérieur à 30.

  expect_true(!is.null(res) && sum(is.na(res$bfp)) == 0)
  # La colonne bfp contient des valeurs manquantes alors qu'il ne devrait
  # pas y en avoir.
  # Revoyez vos corrections de code dans cette section.
})


test_that("
  Étape 3 : Réduction du tableau", {
  res <- read_res("bio_red")
  tpl <- read_tpl("bio_red")

  expect_true(!is.null(res))
  # Le jeu de données `bio` est introuvable après l'étape 3.
  # Avez-vous corrigé le code et l'avez-vous exécuté sans erreur ?
  # Avez-vous bien exécuté l'instruction check_object() à la fin de la section ?

  expect_equivalent(res$ncol, tpl$ncol)
  expect_equivalent(res$nrow, tpl$nrow)
  # Le jeu de données bio doit contenir 7 colonnes et 176 lignes.
  # Le test indique que ce n'est pas le cas, ou que le tableau de données
  # diffère de ce qu'il faut obetenir pour une autre raison.
  # Vérifiez votre code.
})

test_that("
  Étape 4 : Matrice de corrélation", {
  res <- read_res("bio_corr")
  tpl <- read_tpl("bio_corr")

  expect_true(!is.null(res))
  # La matrice de corrélation `bio_corr` est introuvable après l'étape 4.
  # Avez-vous exécuté le code sans erreur ?
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(colnames(res), colnames(tpl))
  # La matrice ne contient pas les variables attendues.
  # Vérifiez que le calcul de la corrélation se fait sur les bonnes variables.

  expect_equivalent(attr(res, "method"), attr(tpl, "method"))
  # La matrice de corrélation n'est pas une matrice de corrélation de Pearson
  # Vérifiez les arguments de la fonction correlation()
})

test_that("
  Étape 5 : Tableau résumé", {
  res <- read_res("bio_sum")
  tpl <- read_tpl("bio_sum")

  expect_true(!is.null(res))
  # Le tableau résumé `bio_sum` est introuvable après l'étape 5.
  # Le code de cette section s'exécute-t-il sans erreur après vos corrections ?
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equal(res$names, tpl$names)
  # Les noms des colonnes de 'bio_sum' diffèrent des valeurs attendues.
  # Vérifiez votre résumé des données.
})


test_that("
  Étape 6 : Graphique de la masse en fonction de la taille",  {
  res <- read_res("pweight")
  tpl <- read_tpl("pweight")

  expect_true(!is.null(res))
  # Le graphique `pweight` est introuvable.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res, tpl)
  # Le nuage de points de la masse en fonction de la taille est incorrect.
})

test_that("
  Étape 7 : Graphique IMC - tour de poignet",  {
  res <- read_res("pbmi")
  tpl <- read_tpl("pbmi")

  expect_true(!is.null(res))
  # Le graphique `pbmi` est introuvable.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res, tpl)
  # Le nuage de points de l'IMC en fonction du tour du poignet est incorrect.
})


test_that("
  Étape 8 : Modélisation", {
  res <- read_res("bmi_lm")
  tpl <- read_tpl("bmi_lm")

  expect_true(!is.null(res))
  # Le modèle `bmi_lm` est introuvable.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res, tpl)
  # La formule utilisée dans le modèle est incorrecte.
  # Corrigez la spécification de votre modèle.
})


test_that("
  Étape 9 : Analyse des résidus", {
  res <- read_res("plm1")
  tpl <- read_tpl("plm1")
  expect_equivalent(res, tpl)
  # Le graphique (A) ne correspond pas à la distribution homogène des résidus.

  res <- read_res("plm2")
  tpl <- read_tpl("plm2")
  expect_equivalent(res, tpl)
  # Le graphique (B) ne correspond pas à la normalité des résidus.

  res <- read_res("plm3")
  tpl <- read_tpl("plm3")
  expect_equivalent(res, tpl)
  # Le graphique (C) ne correspond pas à la distribution des résidus
  # standardisés.

  res <- read_res("plm4")
  tpl <- read_tpl("plm4")
  expect_equivalent(res, tpl)
  # Le graphique (D) ne correspond pas à l'influence des individus sur la
  # régression linéaire.
})
