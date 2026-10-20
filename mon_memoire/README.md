# Analyse des conditions socioéconomiques et de l’accès aux services essentiels à Tchaoudjo 2

Ce dépôt contient l'étude consacrée aux conditions socioéconomiques des ménages de la commune de Tchaoudjo 2 et aux facteurs associés à leur accès aux services essentiels. L’étude s’inscrit dans le cadre de l’élaboration du Plan de développement communal (PDC). Elle mobilise les données d’une enquête menée auprès des ménages du 6 au 8 août 2026 dans quatre zones géographiques : Nord-Est, Nord-Ouest, Sud-Est et Sud-Ouest de la commune de Tchaoudjo 2.

## Objectif de l’étude

L’objectif général est d’analyser les conditions socioéconomiques des ménages et les facteurs associés à leur accès aux services essentiels, afin d’en dégager les principaux enjeux pour le développement communal.

Plus précisément, l'étude vise à :

- caractériser le profil démographique et socioéconomique des ménages de Tchaoudjo 2 ;
- étudier les différences d’accès aux services essentiels selon les caractéristiques des ménages et leur localisation ;
- formuler des recommandations pour améliorer le ciblage des interventions communales.

## Données et méthodes

L’analyse porte sur **1 458 ménages enquêtés**. Le questionnaire couvre notamment la démographie, l’éducation, l’emploi, les revenus, l’habitat, l’eau, la santé, l’hygiène et l’assainissement, l’énergie, l’environnement ainsi que le transport et la mobilité.

Le traitement est réalisé avec **R** dans un document **Quarto**. Les méthodes mobilisées comprennent les statistiques descriptives, les tableaux croisés, les tests du Khi-deux et de Fisher, le V de Cramér, la comparaison de moyennes, le test de Kruskal-Wallis.

## Organisation du projet

```text
mon_memoire/
├── mon_memoire.qmd       # source principale du mémoire
├── _quarto.yml           # configuration du projet Quarto
├── styles.css            # styles de la sortie HTML
├── data/                 # données et dictionnaire de données
├── plots/                # graphiques produits par l’analyse
├── mon_memoire.html      # version HTML générée
├── mon_memoire.pdf       # version PDF générée avec Typst
└── mon_memoire.docx      # version Word générée
```

Les dossiers `_freeze/`, `mon_memoire_cache/` et `mon_memoire_files/` sont générés par Quarto lors de l’exécution et du rendu.

## Prérequis

- [R](https://cran.r-project.org/) ;
- [Quarto](https://quarto.org/) ;
- les packages R suivants : `pacman`, `tidyverse`, `readxl`, `readr`, `janitor`, `tidyr`, `here`, `gt`, `flextable`, `gtsummary`, `gtExtras`, `car`, `rstatix` et `DescTools`.

Le document installe automatiquement `pacman` s’il est absent, puis charge la plupart des dépendances nécessaires. Les packages complémentaires peuvent être installés dans R avec :

```r
install.packages(c("car", "rstatix", "DescTools"))
```

## Reproduire le mémoire

Depuis le dossier `mon_memoire`, exécuter :

```bash
quarto render mon_memoire.qmd
```

Pour produire un format particulier :

```bash
quarto render mon_memoire.qmd --to html
quarto render mon_memoire.qmd --to typst
quarto render mon_memoire.qmd --to docx
```

La source principale utilisée par le document est `data/data_tchaoudjo2.csv`. L’option `freeze: true` conserve les résultats déjà calculés. Pour forcer une nouvelle exécution des cellules R, utiliser :

```bash
quarto render mon_memoire.qmd --execute
```

## Confidentialité des données

Les fichiers du dossier `data/` proviennent d’une enquête auprès des ménages et peuvent contenir des informations sensibles. Ils ne doivent pas être diffusés publiquement sans vérification préalable, anonymisation adéquate et autorisation du responsable des données. Pour un dépôt public, il est recommandé d’exclure les données brutes et de ne publier qu’une version anonymisée ou agrégée.

## Auteur

**Nyuiadzi Komi ZIKPI**

## Licence et réutilisation

Aucune licence n’est actuellement précisée. En l’absence de licence explicite, le contenu et le code ne peuvent pas être considérés comme librement réutilisables. Ajouter une licence adaptée avant toute diffusion publique du projet.
