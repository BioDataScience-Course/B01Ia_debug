# SDD II module 1 : Débogage d'un document Quarto

## Avant-propos

Ce projet nécessite d'avoir assimilé les éléments de base de R comme lire les messages d'erreurs affichés dans la console R et les corriger. Vous devez également avoir assimilé l'ensemble des notions du premier module du cours de Science des Données biologiques 2 pour aborder cet exercice. Il correspond au dépôt GitHub <https://github.com/BioDataScience-Course/B01Ia_debug>.

## Objectifs

Cet exercice est individuel **court** et **cadré**. Vous devrez :

-   corriger un document Quarto
-   visualiser et décrire des données
-   calculer de nouvelles variables
-   connaitre le code à utiliser pour ajuster un modèle et réaliser l'analyse des résidus

## Consignes

Le document `bmi_notebook.qmd` a été écrit par des scientifiques qui souhaitent modéliser l'indice de masse corporelle en fonction du tour du poignet. ce dernier contient malheureusement une multitude d'erreurs. On peut les regrouper en deux grandes catégories :

- les erreurs syntaxiques (code incorrect qui ne s'exécute pas) comme l'oubli de parenthèses, de virgules, de points, de guillemets... 

- les erreurs conceptuelles (code qui s'exécute, mais effectue un mauvais traitement) comme l'ajustement d'un modèle qui n'est pas celui souhaité, la réalisation d'un graphique inadapté aux données ou encore, un calcul incorrect d'une nouvelle variable.

Corrigez ce carnet de notes. On doit être capable de le compiler sans qu'aucune erreur de l'une ou de l'autre catégorie n'apparaisse. Vous avez une batterie de tests à votre disposition depuis l'onglet 'Construire' -> bouton 'Construire tout' pour vérifier vos corrections.

Si vous avez des difficultés à une étape, vous avez deux chunks ('reset1', 'reset2') qui vous permettent de passer les étapes difficiles pour vous et de continuer plus loin. **Le code qui ne s'exécute pas doit impérativement être commenté. Sans cela, il sera impossible de compiler votre carnet de notes.** 

La partie relative à la modélisation et à l'analyse des résidus permettent de réaliser et d'analyser une régression linéaire qui est le sujet du module 1 du cours. L'objectif est de vous familiariser avec le code R nécessaire pour l'analyse plus que pour l'interprétation de ce que vous obtenez. La régression que vous réalisez ici est mauvaise à plusieurs égards (elle s'ajuste mal dans les données et plusieurs problèmes sont observables dans l'analyse des résidus). Focalisez-vous sur le code, nous nous concentrerons sur l'interprétation d'une régression linéaire dans le prochain projet. Mais bien évidemment, vous pouvez tenter de repérer les problèmes si vous avez fini l'exercice et qu'il reste encore du temps.

 Assurez-vous à la fin que vous pouvez compiler une version HTML du fichier `bmi_notebook.qmd` (bouton 'Rendu') sans erreurs. Sinon, corrigez-les avant soumission finale. N'utilisez pas l'argument `echo=FALSE` dans vos chunks. Le code R qui génère les résultats doit rester visible dans la version HTML finale.
 
Enfin, vérifiez que votre dernier commit + push est bien enregistré sur GitHub à la fin de l'exercice.
