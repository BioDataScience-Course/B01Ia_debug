# Débogage de script R

## Avant-propos

Ce projet nécessite d'avoir assimilé les éléments de base de R comme lire les messages d'erreurs affichés dans la console R et les corriger. Vous devez également avoir assimilé l'ensemble des notions du premier module du cours de Science des Données biologiques 2 pour aborder cet exercice. Il correspond au dépôt GitHub <https://github.com/BioDataScience-Course/B01Ia_debug>.

## Objectifs

Cet exercice est individuel **court** et **cadré**. Vous devrez :

-   corriger un script R
-   visualiser et décrire des données
-   calculer de nouvelles variables
-   connaitre le code à utiliser pour ajuster un modèle et réaliser l'analyse des résidus

## Consignes

Le script `R/bmi_lm.R` a été écrit par des scientifiques qui souhaitent modéliser l'indice de masse corporelle en fonction du tour du poignet. Le script contient malheureusement une multitude d'erreurs. On peut les regrouper en deux grandes catégories :

- les erreurs syntaxiques (code incorrect qui ne s'exécute pas) comme l'oubli de parenthèses, de virgules, de points, de guillemets... 

- les erreurs conceptuelles (code qui s'exécute, mais effectue un mauvais traitement) comme l'ajustement d'un modèle qui n'est pas celui souhaité, la réalisation d'un graphique inadapté aux données ou encore, un calcul incorrect d'une nouvelle variable.

Corrigez ce script. On doit être capable de l'exécuter intégralement sans qu'aucune erreur de l'une ou de l'autre catégorie n'apparaisse. Vous avez une batterie de tests à votre disposition depuis l'onglet 'Construire' -> bouton 'Construire tout' pour vérifier vos corrections, mais vous devez avoir exécuté les instructions du script dans l'ordre avant.

Si vous avez des difficultés à une étape, vous avez deux endroits dans le script qui vous permettent de passer les étapes difficiles pour vous et de continuer plus loin : à l'étape 4 et à l'étape 8. 

Pour la dernière partie du script (étapes 8 et 9), il s'agit de réaliser et analyser une régression linéaire qui est le sujet du module 1 du cours. L'objectif est de vous familiariser avec le code R nécessaire pour l'analyse plus que pour l'interprétation de ce que vous obtenez. La régression que vous réalisez ici est mauvaise à plusieurs égards (elle s'ajuste mal dans les données et plusieurs problèmes sont observables dans l'analyse des résidus). Focalisez-vous sur le code, nous nous concentrerons sur l'interprétation d'une régression linéaire dans le prochain projet. Mais bien évidemment, vous pouvez tenter de repérer les problèmes si vous avez fini l'exercice et qu'il reste encore du temps.
