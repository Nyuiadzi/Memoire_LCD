#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: tbl-echantillon
#| tbl-cap: "Echantillon minimum représentatif pour chaque zone d’enquête"
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: tbl-echantillon_realise
#| tbl-cap: "Le nombre de ménage enquêtés à l'issue d’enquête"
#
#
#
#
#
#
#
#
#
#
#
#
#
#| echo: true
#| message: false
#| warning: false
if(!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse,
               readxl, readr, janitor,
               tidyr, here,
               gt,flextable, gtsummary, gtExtras)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| echo: true
#| message: false
#| warning: false
#| output: false
# Importation des données
data_tchaoudjo2 <- read_csv(here("data/enquete_tchaoudjo2_clean3.csv"))
head(data_tchaoudjo2, 10) # visualisation des 10 premières lignes du jeu de données
#
#
#
#
#
#
#
#
#
#| echo: false
#| label: tbl-sexe
#| tbl-cap: "Répartition des ménages enquêtés selon le sexe du chef de ménage"
data_tchaoudjo2 |> 
  tabyl(sexe) |> 
  adorn_totals("row") |>
  adorn_pct_formatting(digits = 1) |> 
  rename("Sexe" = sexe, "Effectif" = n, "Pourcentage" = percent) |> 
  gt() |>
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(
      rows = Sexe == "Total"
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#| echo: false
#| label: tbl-age_sexe
#| tbl-cap: "Répartition des enquêtés selon la tranche d'âge et le sexe du chef de ménage"
data_tchaoudjo2 |> 
  tabyl(age, sexe) |> 
  mutate(Total = Féminin + Masculin) |> 
  as.data.frame() |>
  adorn_totals("row") |>
  rename(Âge = age) |> 
  gt()
#
#
#
#| echo: false
#| label: fig-tranche_age
#| fig-cap: "Répartition des enquêtés par tranche d'âge et par sexe"
data_tchaoudjo2|>
  ggplot() +
  aes(x = age, fill = sexe)+
  geom_bar(position = "dodge")+

  geom_text(
    aes(
      label = after_stat(count),
      group = sexe
    ),
    stat = "count",
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 3
  ) +

  labs(title = "",
       caption = "",
       x = "Sexe",
       y = "Effectif",
       fill = "Sexe") +
        
  theme_bw() +
    theme(
    # Titre du graphique
    plot.title = element_text(size = 14, face = "bold"),
    # Sous-titre du graphique
    plot.subtitle = element_text(size = 12, face = "italic"),
    # Note de bas de page du graphique
    plot.caption = element_text(size = 10, face = "italic"),
    # Valeurs graduées de l'axe Y
    axis.text.y = element_text(size = 12),
    # Modalités de l'axe X
    axis.text.x = element_text(size = 10, face = "bold",  angle = 45, hjust = 1),
    # Titre de l'axe X
    axis.title.x = element_text(size = 12, face = "bold"),
    # Titre de l'axe Y
    axis.title.y = element_text(size = 12,face = "bold"),
    # Légende
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(0.8, "cm")
)
#
#
#
#
#
#
#
#
#
#
#
#| echo: false
#| label: tbl-situation_matri
#| tbl-cap: "Répartition des enquêtés selon la situation matrimoniale et le sexe du chef de ménage"
data_tchaoudjo2 |> 
  tabyl(situation_matri, sexe) |> 
  mutate(Total = Féminin + Masculin) |> 
  arrange(desc(Total)) |> 
  as.data.frame() |>
  adorn_totals("row") |>
  rename(Situation_matrimoniale = situation_matri) |> 
  gt()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
khi2_matri_sexe  <- chisq.test(
  table(data_tchaoudjo2$situation_matri, data_tchaoudjo2$sexe))
khi2_matri_sexe
#
#
#
#| echo: false
# Vérification des effectifs attendus et de l'effectif attendus minimum
khi2_matri_sexe$expected
effectif_min  <- min(khi2_matri_sexe$expected)
#
#
#
#| echo: false
paste("L'effectif attendu minimum est :", round(effectif_min, 2))
#
#
#
# Calcul du V de Cramer
v_cramer <- DescTools::CramerV(
  table(data_tchaoudjo2$situation_matri, data_tchaoudjo2$sexe))
#
#
#
#| echo: false
paste("La valeur du V de Cramer est :", round(v_cramer, 2))
#
#
#
#
#
#
#
#
#
#
#
#| echo: false
#| output: false
data_tchaoudjo2 <- data_tchaoudjo2 |>
  mutate(
    ethnie = if_else(ethnie == "Nawba", "Nawda", ethnie)
  )
#
#
#
#| echo: false
#| output: false
data_tchaoudjo2 |> 
  tabyl(ethnie) |> 
  arrange(desc(n))
#
#
#
#| echo: false
data_tchaoudjo2 <- data_tchaoudjo2 |> 
  mutate(
    ethnie_rec = case_when(
      ethnie %in% c("Ife", "Konkomba", "Sola", "Akposso", "Lokpa", "Mina", "Pouda", "Samourè", "Yaka", "Zarma") ~ "Autres",
      TRUE ~ ethnie
    )
  )
#
#
#
#
#| echo: false
#| output: false
data_tchaoudjo2 |> 
  tabyl(ethnie_rec) |> 
  arrange(desc(n))
#
#
#
#
#
#
#
#| echo: false
#| label: fig-ethinie
#| fig-cap: "Répartition des ménages selon l'ethnie du chef de ménage"
data_tchaoudjo2 |>
  count(ethnie_rec) |>
  ggplot(aes(x = reorder(ethnie_rec, -n), y = n)) +
  geom_col(fill = "steelblue") +
  geom_text(
    aes(label = n),
    vjust = -0.3
  ) +
  labs(
    title = "",
    caption = "",
    x = "Ethnie",
    y = "Effectif"
  ) +
  theme_bw()
#
#
#
#
#
#
#
#| echo: false
#| label: fig-religion
#| fig-cap: "Répartition des ménages selon la religion du chef de ménage"
tab_religion <- table(data_tchaoudjo2$religion)
pourcentage <- round(prop.table(tab_religion) * 100, 1)
labels <- paste0(names(tab_religion), " : ", pourcentage, "%")

pie(
  tab_religion,
  labels = labels,
  #col = c("skyblue", "yellow", "tomato", "seagreen"),
  main = ""
)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
data_tchaoudjo2 |> 
    select(personne_nb_charge) |> 
    summary()
#
#
#
#| echo: false
#| label: fig-perso_charge
#| fig-cap: "Répartition des individus selon le nombre de personnes à charge"
data_tchaoudjo2 |>
  ggplot(aes(x = personne_nb_charge)) +
  geom_histogram(
    binwidth = 1,
    color = "blue",
    fill = "skyblue"
  ) +
  scale_x_continuous(
    breaks = seq(0, 30, by = 2)
  ) +
  labs(
    title = "",
    caption = "",
    x = "Nombre de personnes à charge",
    y = "Effectif"
  ) +
  theme_bw()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
data_tchaoudjo2 |> 
  tabyl(enfant_pas_naissance) |> 
  adorn_pct_formatting(digits = 1) |> 
  rename("Enfant sans acte de naissance" = enfant_pas_naissance, "Effectif" = n, "Pourcentage" = percent) |> 
  gt() |>
    tab_header(
      title = "Répartition des enquêtés selon qu'ils aient ou non des enfants ne disposant pas d'un acte de naissance",
      subtitle = ""
    )
#
#
#
enquete3 |> 
  tabyl(enfant_pas_naissance_raison)

enquete3 |> 
  tabyl(enfant_pas_naissance_raison, show_na = FALSE) |> 
  adorn_pct_formatting(digits = 1) |> 
  arrange(desc(n)) |> 
  rename("Raisons" = enfant_pas_naissance_raison, "Effectif" = n, "Pourcentage" = percent) |> 
  gt() |> 
    tab_header(
      title = "Raison de l'absence d'acte de naissance pour certains enfant",
      subtitle = ""
    )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
