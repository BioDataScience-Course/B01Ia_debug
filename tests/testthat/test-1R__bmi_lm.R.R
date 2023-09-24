# Vérification de R/bmi_lm.R

test_that("Étape 1 : Importation des données", {
  expect_true(is_identical_to_ref("biometry"))
  # Le jeu de données `biometry` est introuvable ou incorrect après l'étape 1
  # Avez-vous corrigé les erreurs dans le code ?
  # Avez-vous exécuté les instructions au-dessus dans l'ordre ?
})

test_that("Étape 2 : Calcul de nouvelles variables", {
  expect_true(is_identical_to_ref("bio1"))
  # Le jeu de données `bio1` est introuvable ou incorrect après l'étape 2
  # Vous n'avez peut-être pas corrigé toutes les erreurs dans le code ?
  # Avez-vous bien exécuté les instructions dans l'ordre ?
})

test_that("Étape 3 : Réduction du tableau", {
  expect_true(is_identical_to_ref("bio2"))
  # Le jeu de données `bio2` est introuvable ou incorrect
  # Si vous avez généré ce jeu de données, recontrôlez le code par rapport au
  # commentaire juste au dessus... il y a un piège !
})

test_that("Étape 4 : Matrice de corrélation", {
  expect_true(is_identical_to_ref("bio_corr"))
  # La matrice de corrélation est introuvable ou n'est pas la bonne
  # Vérifiez que ce code s'exécute sans erreurs après vos corrections.
  # Vérifiez les arguments de la fonction `correlation()`. Il vous faut une
  # corrélation de Pearson.
})

test_that("Étape 5 : Tableau résumé", {
  expect_true(is_identical_to_ref("bio_summ"))
  # Le tableau résumé `bio_summ` est introuvable ou incorrect
  # Le code de cette section s'exécute-t-il sans erreur après vos corrections ?
  # Il y a plusieurs erreurs subtiles à corriger à ce niveau.
})

test_that("Étape 6 : Graphique de la masse en fonction de la taille",  {
  expect_true(is_identical_to_ref("chart_weight"))
  # Le graphique masse - tour de taille n'est pas généré ou est incorrect
  # Vérifiez le code à ce niveau. Éventuellement, exécutez ce code sans
  # l'assignation à `chart_weight` pour voir le graphique directement : c'est
  # plus facile pour le débogage.
})

test_that("Étape 7 : Graphique de l'IMC en fonction du tour de poignet",  {
  expect_true(is_identical_to_ref("chart_bmi"))
  # Le graphique IMC - tour de poignet n'est pas généré ou est incorrect
  # Vérifiez le code à ce niveau. Éventuellement, exécutez ce code sans
  # l'assignation à `chart_bmi` pour voir le graphique directement : c'est plus
  # facile pour le débogage.
})

test_that("Étape 8 : Modélisation", {
  expect_true(is_identical_to_ref("bmi_lm"))
  # Le modèle `bmi_lm` est introuvable ou il est incorrect
  # Est-ce le bon modèle ?
  # L'avez-vous généré après avoir relu les données `bio2` ?
})

test_that("Étape 9 : Analyse des résidus", {
  expect_true(is_identical_to_ref("resid1"))
  # Le graphique (A) ne correspond pas à la distribution des résidus en
  # fonction des valeurs prédites
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.

  expect_true(is_identical_to_ref("resid2"))
  # Le graphique (B) n'est pas celui qui permet de vérifier la Normalité des
  # résidus
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.

  expect_true(is_identical_to_ref("resid3"))
  # Le graphique (C) n'est pas celui qui étudie l'homoscédasticité des résidus
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.

  expect_true(is_identical_to_ref("resid4"))
  # Le graphique (D) ne présente pas effet de levier, résidus et distance de
  # Cook simultanément
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.
})
