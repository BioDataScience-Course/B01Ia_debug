# Vérification de R/bmi_lm

test_that("Le jeu de données biometry est-il correct après l'étape 1 ?", {
  res <- read_res("biometry")
  expect_true(!is.null(res))
  # Le jeu de données `biometry` est introuvable après l'étape 1.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?
})

test_that("Le jeu de données bio est-il correct après l'étape 2 ?", {
  res <- read_res("bio_smutate")
  tpl <- read_tpl("bio_smutate")

  expect_true(!is.null(res))
  # Le jeu de données `bio` est introuvable après l'étape 2
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(names(res), names(tpl))
  # Des colonnes sont manquantes ou ne portent pas le bon nom

  expect_lt(collapse::fmean(res$bmi), 50)
  # Les valeurs d'IMC sont trop élevés. Par exemple, L'OMS définit l'obésité
  # quand l'IMC est égale ou supérieur à 30.

  expect_equivalent(sum(is.na(res$bfp)), 0)
  # La colonne bfp comprend des valeurs manquantes
})


test_that("Le jeu de données bio est-il correct après l'étape 3 ?", {
  res <- read_res("bio_red")
  tpl <- read_tpl("bio_red")

  expect_true(!is.null(res))
  # Le jeu de données `bio` est introuvable après l'étape 3.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res$ncol, tpl$ncol)
  expect_equivalent(res$nrow, tpl$nrow)
  # Le jeu de données bio doit comprendre 7 colonnes et 176 lignes.
})

test_that("La matrice de corrélation de Pearson est- elle correcte après l'étape 4 ?", {
  res <- read_res("bio_corr")
  tpl <- read_tpl("bio_corr")

  expect_true(!is.null(res))
  # La matrice de corrélation `bio_corr` est introuvable après l'étape 4.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(colnames(res), colnames(tpl))
  # La matrice comprend trop de colonnes et de lignes

  expect_equivalent(attr(res, "method"), attr(tpl, "method"))
  # La matrice de corrélation n'est pas une matrice de corrélation de Pearson
})

test_that("Le tableau résumé `bio_sum` est-il correct  après l'étape 5 ?", {
  res <- read_res("bio_sum")
  tpl <- read_tpl("bio_sum")

  expect_true(!is.null(res))
  # Le tableau résumé `bio_sum` est introuvable après l'étape 5.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equal(res$names, tpl$names)
  # Les noms des colonnes diffèrent des valeurs attendues.
})


test_that("Le graphique pweight, réalisé à l'étape 6, est-il correct ?",  {
  res <- read_res("pweight")
  tpl <- read_tpl("pweight")

  expect_true(!is.null(res))
  # Le graphique `pweight` est introuvable.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res, tpl)
  # Le nuage de points de la masse en fonction de la taille est incorrects
})

test_that("Le graphique pbmi, réalisé à l'étape 6, est-il correct ?",  {
  res <- read_res("pbmi")
  tpl <- read_tpl("pbmi")

  expect_true(!is.null(res))
  # Le graphique `pbmi` est introuvable.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res, tpl)
  # Le nuage de points de l'IMC en fonction du tour du poignet est incorrect.
})


test_that("L'objet `bmi_lm.rds`, réalisé à l'étape 7, est-il correct ?", {
  res <- read_res("bmi_lm")
  tpl <- read_tpl("bmi_lm")

  expect_true(!is.null(res))
  # Le model `bmi_lm` est introuvable.
  # Avez-vous bien exécuté l'instruction check_object() à la fin ?

  expect_equivalent(res, tpl)
  # La formule utilisé dans le modèle est incorrecte.
})


test_that("Les graphiques de l'analyse des résidus, réalisé à l'étape 7, sont-ils corrects ?", {
  res <- read_res("plm1")
  tpl <- read_tpl("plm1")
  expect_equivalent(res, tpl)
  # Le graphique ne correspond pas à la distribution homogène des résidus.

  res <- read_res("plm2")
  tpl <- read_tpl("plm2")
  expect_equivalent(res, tpl)
  # Le graphique ne correspond pas à la normalité des résidus.

  res <- read_res("plm3")
  tpl <- read_tpl("plm3")
  expect_equivalent(res, tpl)
  # Le graphique ne correspond pas à la distribution des résidus standardiséss.

  res <- read_res("plm4")
  tpl <- read_tpl("plm4")
  expect_equivalent(res, tpl)
  # Le graphique ne correspond pas à l'influence des individus sur la régression linéaire.
})

