#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
#| echo: false
#| label: fig-tranche_age
#| fig-cap: "Répartition des individus par tranche d'âge et le sexe"
data_tchaoudjo2|>
  ggplot() +
  aes(x = age, fill = sexe)+
  geom_bar(position = "dodge")+
  labs(title = "Répartition des enquêtés par tranche d'âge et le sexe",
       caption = "Source : Enquête ménages Tchaoudjo 2, 2026",
       x = "Sexe",
       y = "Effectif")+
  theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
#
#
#
#
#
#| echo: false
#| label: tbl-situation_matri
#| tbl-cap: "Répartition des ménages enquêtés selon la situation matrimoniale du chef de ménage"
data_tchaoudjo2 |> 
  tabyl(situation_matri) |> 
  adorn_pct_formatting(digits = 1) |> 
  arrange(desc(n)) |>
  rename("Situation matrimoniale" = situation_matri, "Effectif" = n, "Pourcentage" = percent) |> 
  gt() |>
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(
      rows = "Situation matrimoniale" == "Total"
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
#
#
#| echo: false
#| label: tbl-situation_matri
#| tbl-cap: "Répartition des ménages enquêtés selon la situation matrimoniale et le sexe du chef de ménage"
data_tchaoudjo2 |> 
  tabyl(situation_matri, sexe) |> 
  mutate(Total = Féminin + Masculin) |> 
  arrange(desc(Total)) |>
  select(-Total) |>
  adorn_totals(c("row", "col")) |>
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
#
#
#
#
#
#
#
#
#
#
