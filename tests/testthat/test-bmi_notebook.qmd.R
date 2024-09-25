# Vérification de bmi_notebook.qmd

bmi <- parse_rmd("../../bmi_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("bmi_notebook.qmd"))
  # La version compilée HTML du rapport est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("bmi_notebook.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Description des données",
    "Modélisation de l'IMC en fonction du tour de poignet",
    "Analyse des résidus", "Discussion et conclusion")
    %in% (rmd_node_sections(bmi) |> unlist() |> unique())))
  # Les sections (titres) attendues du document ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import", "mutate", "reduce", "reset1",
    "correlation", "summarise", "chart", "reset2", "lm", "lmsummary",
    "resid1", "resid2", "resid3", "resid4")
    %in% rmd_node_label(bmi)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(bmi))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(bmi[[1]]$author != "___")
  expect_true(!grepl("__", bmi[[1]]$author))
  expect_true(grepl("^[^_]....+", bmi[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", bmi[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", bmi[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunk 'import' : importation des données", {
  expect_true(is_identical_to_ref("import", "names"))
  # Les colonnes dans le tableau `biometry` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Vérifiez et réexécutez-le
  # script R/import_abalone.R pour corriger le problème.

  expect_true(is_identical_to_ref("import", "classes"))
  # La nature des variables (classe) dans le tableau `urchin` est incorrecte
  # Vérifiez l'importation du jeu de données.
})

test_that("Chunk 'mutate' : calcul de nouvelles variables", {
  expect_true(is_identical_to_ref("mutate", "names"))
  # Les colonnes dans le tableau `bio1` importé ne sont pas celles attendues.
  # Vérifiez le calcul des variables `bmi` et `bfp` pour corriger le problème.

  expect_true(is_identical_to_ref("mutate", "classes"))
  # La nature des variables (classe) dans le tableau `bio1` est incorrecte.
  # Vérifiez le calcul des variables `bmi` et `bfp` pour corriger le problème.

  expect_true(is_identical_to_ref("mutate", "units"))
  # Les unités renseignées pour les variables de `bio1` sont incorrectes
  # Vérifiez la labélisation des variables `bmi` et `bfp`.

  expect_true(is_identical_to_ref("mutate", "nas"))
  # Les valeurs manquantes pour les variables de `bio1` sont incorrectes
  # Vérifiez particulièrement le calcul de la variable de `bfp`
})

test_that("Chunk 'reduce' : réduction de bio1 en bio2", {
  expect_true(is_identical_to_ref("reduce", "names"))
  # Les colonnes dans le tableau `bio2` ne sont pas celles attendues.
  # Vérifiez particulièrement la sélection des colonnes du tableau pour
  # corriger le problème.

  expect_true(is_identical_to_ref("reduce", "nrow"))
  # Le nombre de lignes dans le tableau `bio2` est incorrect.
  # Vérifiez tout particulièrement le filtre réalisé sur le tableau  pour
  # corriger le problème.

  expect_true(is_identical_to_ref("reduce", "nas"))
  # Les valeurs manquantes pour les variables de `bio2` sont incorrectes
  # Vérifiez la réduction du tableau pour corriger le problème.
})

test_that("Chunk 'correlation' : matrice de corrélation", {
  expect_true(is_identical_to_ref("correlation"))
  # La matrice de corrélation est introuvable ou n'est pas la bonne
  # Vérifiez que ce code s'exécute sans erreurs après vos corrections.
  # Vérifiez les arguments de la fonction `correlation()`. Il vous faut une
  # corrélation de Pearson.
})

test_that("Chunk 'summarise' : tableau résumé", {
  expect_true(is_identical_to_ref("summarise", "names"))
  # Le tableau résumé `bio_summ` est introuvable ou incorrect.
  # Vérifiez particulièrement les étapes de résumé du tableau pour corriger le
  # problème.

  expect_true(is_identical_to_ref("summarise", "nrow"))
  # Le nombre de lignes dans le tableau `bio_summ` est incorrect.
  # Vérifiez tout particulièrement l'instruction lié au groupe dans vos données
  # (sgroup_by()) pour corriger le problème.

  expect_true(is_identical_to_ref("import", "units"))
  # Les unités renseignées pour les variables de `bmi_summ` sont incorrectes.
  # Vérifiez la labélisation des variables pour corriger le problème.

  expect_true(is_identical_to_ref("summarise", "nas"))
  # Les valeurs manquantes pour les variables de `bio2` sont incorrectes
  # Vérifiez le calcul réalisé sur les groupes (ssummarise()) pour corriger le
  #  problème.
})


test_that("Chunk 'chart' : Graphique de l'IMC en fonction du tour de poignet",  {
  expect_true(is_identical_to_ref("chart"))
  # Le graphique IMC - tour de poignet n'est pas généré ou est incorrect
  # Vérifiez le code à ce niveau.
})

test_that("Chunk 'lm' : Modélisation", {
  expect_true(is_identical_to_ref("lm"))
  # Le modèle `bmi_lm` est introuvable ou il est incorrect
  # Est-ce le bon modèle ?
  # L'avez-vous généré après avoir relu les données `bio2` ?
})


test_that("Chunks 'resid1', 'resid2', 'resid3', 'resid4' : Analyse des résidus", {
  expect_true(is_identical_to_ref("resid1"))
  # Le graphique ne correspond pas à la distribution des résidus en
  # fonction des valeurs prédites
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.

  expect_true(is_identical_to_ref("resid2"))
  # Le graphique n'est pas celui qui permet de vérifier la Normalité des
  # résidus
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.

  expect_true(is_identical_to_ref("resid3"))
  # Le graphique n'est pas celui qui étudie l'homoscédasticité des résidus
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.

  expect_true(is_identical_to_ref("resid4"))
  # Le graphique ne présente pas effet de levier, résidus et distance de
  # Cook simultanément
  # Inspirez-vous de la page d'aide à ?chart.lm et du cours en ligne.
})
