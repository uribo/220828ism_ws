################################
# スライドで示したグラフの再現用コード
################################
library(reprex)
library(dplyr)
library(sf)
library(ggplot2)
library(patchwork)
custom_pals <- c("#953F56", "#0F1347", "#77835E", "#BC974E", "#DED4BA")
ggplot2::theme_set(ggplot2::theme_gray(base_size = 16))
options(
  tibble.print_min = 5L,
  reprex.highlight.hl_style  = "base16/classic-light",
  reprex.highlight.font      = "Fira Code Regular",
  reprex.highlight.font_size = 36,
  reprex.highlight.other     = "--line-numbers --line-number-length=2 --zeroes")
filter_shikoku <- function(data, var = prefecture) {
  data |>
    dplyr::filter({{ var }} %in% c("徳島県", "香川県", "愛媛県", "高知県"))
}

# 写像・データ・可視化 --------------------------------------------------------------
library(palmerpenguins)
p_penguins_scatter <-
  penguins |>
  ggplot() +
  aes(flipper_length_mm, bill_length_mm) +
  geom_point(aes(color = species),
             alpha = 0.5,
             show.legend = FALSE) +
  geom_smooth(method = "lm",
              aes(group = species),
              se = FALSE,
              color = "#0E0E0E") +
  scale_color_manual(values = custom_pals) +
  theme_light() +
  labs(title = "ペンギンの体の大きさの関係",
       x = "翼の長さ(mm)",
       y = "くちばしの長さ(mm)")
p_penguins_scatter +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")


# set.seed(123)
# penguins |>
#   select(species, flipper_length_mm, bill_length_mm) |>
#   slice_sample(n = 15) |>
#   gt::gt() |>
#   gt::gtsave("out.png")

# データ可視化の重要性 --------------------------------------------------------------
anscombe

anscombe_long <-
  anscombe |>
  tidyr::pivot_longer(
    tidyselect::everything(),
    names_to = c(".value", "set"),
    names_pattern = "(.)(.)")

anscombe_long |>
  group_by(set) |>
  group_map(
    ~ ggplot(.x, aes(x, y)) +
      geom_point(color = custom_pals[1]) +
      geom_smooth(method = lm, se = FALSE, color = custom_pals[2])) |>
  wrap_plots(ncol = 4)

library(datasauRus)
datasaurus_dozen |>
  filter(dataset == "dino") |>
  ggplot(aes(x = x, y = y)) +
  geom_point()

datasaurus_dozen |>
  filter(dataset != "dino") |>
  ggplot(aes(x = x, y = y, colour = dataset)) +
  geom_point() +
  theme(legend.position = "none") +
  facet_wrap(~dataset, ncol = 3)


# ゲシュタルトの法則に基づく情報の理解 ---------------------------------------------------------
d <-
  penguins |>
  select(flipper_length_mm, bill_length_mm, species) |>
  filter(!is.na(flipper_length_mm))

p <-
  d |>
  ggplot() +
  aes(flipper_length_mm, bill_length_mm)

p +
  geom_point() +
  theme_void()

p +
  ggforce::geom_mark_ellipse(aes(color = species), show.legend = FALSE) +
  geom_point(aes(color = species), show.legend = FALSE) +
  theme_void()

ggplot() +
  geom_line(
    data = structure(
      list(year = 2009:2008, spending = c(294834, 317431)),
      row.names = c(NA,-2L),
      class = c("tbl_df", "tbl", "data.frame")
    ),
    aes(year, spending)) +
  geom_line(
    data = structure(
      list(
        year = 2019:2012,
        spending = c(278855, 282732,
                     273835, 295192, 277856, 320073, 308550, 313491)
      ),
      row.names = c(NA,-8L),
      class = c("tbl_df", "tbl", "data.frame")
    ),
    aes(year, spending)) +
  scale_x_continuous(breaks = seq.int(2008, 2019, by = 2)) +
  theme_void()

structure(
  list(
    year = 2019:2008,
    spending = c(
      278855,
      282732,
      273835,
      295192,
      277856,
      320073,
      308550,
      313491,
      272403,
      317357,
      294834,
      317431
    )
  ),
  row.names = c(NA,-12L),
  class = c("tbl_df",
            "tbl", "data.frame")
) |>
  ggplot() +
  aes(year, spending) +
  geom_line() +
  theme_void()

structure(
  list(
    prefecture = c("徳島県", "香川県", "愛媛県",
                   "高知県"),
    spending = c(278855, 308268, 253697, 302399)
  ),
  row.names = c(NA,-4L),
  class = c("tbl_df", "tbl", "data.frame")) |>
  mutate(prefecture = recode(prefecture,
                             `徳島県` = "A",
                             `香川県` = "B",
                             `愛媛県` = "C",
                             `高知県` = "D")) |>
  ggplot() +
  aes(prefecture, spending) +
  geom_bar(fill = "#0F1347", stat = "identity") +
  theme_void() +
  theme(axis.text.x = element_text(size = 24))

p <-
  structure(
    list(
      year = c(
        2019L,
        2018L,
        2017L,
        2016L,
        2015L,
        2014L,
        2013L,
        2012L,
        2011L,
        2010L,
        2009L,
        2008L,
        2019L,
        2018L,
        2017L,
        2016L,
        2015L,
        2014L,
        2013L,
        2012L,
        2011L,
        2010L,
        2009L,
        2008L
      ),
      prefecture = c(
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "徳島県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県",
        "香川県"
      ),
      spending = c(
        278855,
        282732,
        273835,
        295192,
        277856,
        320073,
        308550,
        313491,
        272403,
        317357,
        294834,
        317431,
        308268,
        318612,
        299324,
        285575,
        312552,
        306242,
        319050,
        309212,
        318306,
        313848,
        308221,
        325338
      )
    ),
    row.names = c(NA,-24L),
    class = c("tbl_df",
              "tbl", "data.frame")
  ) |>
  ggplot() +
  aes(year, spending, color = prefecture, group = prefecture) +
  geom_point(show.legend = FALSE) +
  theme_void()
p + geom_line(show.legend = FALSE)



# ggplot2を利用可能にする ------------------------------------------------------------
# install.packages("ggplot2")
# ggplot2パッケージの読み込み
# 発表資料では2022年8月時点でのCRAN最新バージョンである3.3.6を利用します
library(ggplot2)

# tidyverseパッケージに内包されているため、こちらを読み込んでもOKです
# install.packages("tidyverse")
# library(tidyverse)


# ggplot2の第一歩 -------------------------------------------------------------
# データ操作のためのパッケージ
library(dplyr, warn.conflicts = FALSE)
penguins_xy <-
  palmerpenguins::penguins |>
  select(flipper_length_mm, bill_length_mm, species) |>
  filter(!is.na(flipper_length_mm))

ggplot(data = penguins_xy) +
  aes(x = flipper_length_mm,
      y = bill_length_mm) +
  geom_point()

p <-
  scales::demo_continuous(c(1, 4))
p +
  geom_point(data = tibble::tibble(x = c(1, 2, 3, 4)),
             aes(x = x),
             size = 6)
p +
  geom_point(data = tibble::tibble(x = c(1, 2, 3, 4),
                                   z = c("1", "2", "3", "4")),
             aes(x = x,
                 shape = z),
             size = 6,
             show.legend = FALSE) +
  scale_shape_manual(values = c(16, 15, 17, 18))
p +
  geom_point(data = tibble::tibble(x = c(1, 2, 3, 4),
                                   z = c("1", "2", "3", "4")),
             aes(x = x,
                 color = z),
             size = 6,
             shape = 17,
             show.legend = FALSE) +
  ggokabeito::scale_color_okabe_ito()


# 審美的要素の指定方法 ------------------------------------------------
ggplot(data = penguins_xy) +
  aes(x = flipper_length_mm,
      y = bill_length_mm,
      color = species) +
  geom_point()

# 1. aes()はレイヤとしてggplotオブジェクトに追加しても良い
ggplot(data = penguins_xy) +
  aes(x = flipper_length_mm,
      y = bill_length_mm)

# 2. ggplot(mapping = aes(...))として与えても良い
ggplot(data = penguins_xy,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm))

# 3. ggplot(data = ,mapping = aes(x = ,y = ))は暗黙的に引数を省略して記述できる
ggplot(penguins_xy,
       aes(flipper_length_mm, bill_length_mm))

ggplot(data = penguins_xy) +
  aes(x = flipper_length_mm,
      y = bill_length_mm,
      color = species,
      group = species) +
  geom_point(show.legend = FALSE) +
  geom_smooth(method = "lm",
              show.legend = FALSE)

ggplot(data = penguins_xy) +
  aes(x = flipper_length_mm,
      y = bill_length_mm) +
  geom_point(aes(color = species),
             show.legend = FALSE) +
  geom_smooth(aes(group = species),
              method = "lm",
              show.legend = FALSE)

# 人口データを可視化してみよう ---------------------------------------------------------
board <- pins::board_url(
  c(ssdse_b = "https://raw.githubusercontent.com/uribo/220828ism_ws/main/df-ssdse-b/data.rds"))
df_ssdse_b <-
  board |>
  pins::pin_download("ssdse_b") |>
  readr::read_rds()

glimpse(df_ssdse_b)

df_ssdse_b2019 <-
  df_ssdse_b |>
  filter(year == 2019)

df_ssdse_b2019 |>
  ggplot() +
  aes(prefecture, population) +
  geom_bar(stat = "identity")
df_ssdse_b2019 |>
  ggplot() +
  aes(prefecture, population) +
  geom_bar(stat = "identity") +
  # 棒を縦に並べる
  coord_flip()
df_ssdse_b2019 |>
  # おおよその緯度の順番に配置する
  mutate(prefecture = forcats::fct_rev(forcats::fct_inorder(prefecture))) |>
  ggplot() +
  aes(prefecture, population) +
  geom_bar(stat = "identity") +
  coord_flip()

# ジオメトリレイヤ --------------------------------------------------------------------
df_ssdse_b2019 |>
  ggplot() +
  aes(food_expenses, spending) +
  geom_point()

df_ssdse_b2019 |>
  filter_shikoku() |>
  ggplot() +
  aes(prefecture, population) +
  geom_bar(stat = "identity")

df_ssdse_b |>
  filter_shikoku() |>
  ggplot() +
  aes(year, population, group = prefecture) +
  geom_line()

df_ssdse_b |>
  filter_shikoku() |>
  ggplot() +
  aes(prefecture, spending) +
  geom_boxplot()

df_ssdse_b2019 |>
  ggplot() +
  aes(x = spending) +
  geom_histogram(bins = 10)

df_ssdse_b |>
  filter_shikoku() |>
  filter(between(year, 2015, 2019)) |>
  ggplot() +
  aes(prefecture, population) +
  geom_bar(stat = "identity",
           aes(group = year, fill = year),
           position = "dodge") +
  scale_fill_viridis_c() +
  coord_flip()


# 統計処理レイヤ -----------------------------------------------------------------
# geom_bar

tibble::tibble(
  group = c(rep("a", 4), rep("b", 2), "c")
) |>
  ggplot() +
  aes(x = group) +
  geom_bar(stat = "count")

p <-
  df_ssdse_b2019 |>
  ggplot() +
  aes(x = spending)
p + geom_bar(stat = "bin", bins = 10)
p + stat_bin(bins = 10)
p + geom_histogram(bins = 10)


# 座標系 ---------------------------------------------------------------------
p <-
  ggplot(data = penguins_xy) +
  aes(x = flipper_length_mm,
      y = bill_length_mm) +
  geom_point()

p +
  coord_fixed(ratio = 1)
p +
  coord_flip()
# p +
#   coord_equal()

p <-
  df_ssdse_b2019 |>
  filter_shikoku() |>
  ggplot() +
  aes(prefecture, population, fill = prefecture) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = custom_pals[1:4]) +
  scale_y_continuous(breaks = c(500000, 750000, 1000000, 1250000, 1500000))

p

p +
  coord_polar()

p <-
  df_ssdse_b2019 |>
  filter_shikoku() |>
  ggplot() +
  aes(x = 1, population, fill = prefecture) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = custom_pals[1:4])

p

p +
  coord_polar(theta = "y", start = 0)


# スケール --------------------------------------------------------------------
p1 <-
  scales::demo_continuous(c(1, 100)) +
  labs(title = "連続値のスケール")
p2 <-
  scales::demo_log10(c(1, 100)) +
  labs(title = "対数スケール")
p3 <-
  scales::demo_datetime(x = seq.int(lubridate::make_datetime(2022, 8, 1),
                                    lubridate::make_datetime(2022, 8, 31),
                                    by = 1)) +
  labs(title = "日付・時間のスケール")
p1 + p2 + p3 +
  plot_layout(ncol = 3)

df_ssdse_b |>
  filter_shikoku() |>
  ggplot() +
  aes(year, population,
      group = prefecture,
      color = prefecture) +
  geom_line()

df_ssdse_b |>
  filter_shikoku() |>
  ggplot() +
  aes(year, population,
      group = prefecture,
      color = prefecture) +
  geom_line() +
  scale_x_continuous(
    breaks = seq.int(2008, 2019, by = 2)) +
  scale_y_log10() +
  scale_color_viridis_d()

# ファセット -------------------------------------------------------------------
p <-
  df_ssdse_b |>
  filter_shikoku() |>
  select(year, prefecture, starts_with("birth")) |>
  tidyr::pivot_longer(cols = starts_with("birth"),
                      names_to = "gender",
                      values_to = "value",
                      names_prefix = "birth_") |>
  ggplot() +
  aes(year, value) +
  geom_line(aes(group = prefecture, color = prefecture)) +
  scale_x_continuous(breaks = seq.int(2008, 2019, by = 2)) +
  scale_color_manual(values = custom_pals[1:4])

p$data

p_facet <-
  p +
  facet_wrap(~ gender,
             scales = "free_y",
             ncol = 2)
p +
  facet_grid(rows = vars(gender),
             scales = "free_y")


# テーマ ---------------------------------------------------------------------
res <-
  ls(pattern = "^theme_(bw|classic|dark|gray|light)$", "package:ggplot2") %>%
  purrr::map(
    ~ p_facet +
      labs(title = glue::glue("{.x}()")) +
      rlang::as_function(.x)()
  )
patchwork::wrap_plots(res, nrow = 2, guides = "collect")

p_facet +
  theme_classic() +
  theme(
    strip.background = element_rect(fill = "gray"),
    strip.text = element_text(color = "white",
                              face = "bold"),
    legend.position = "top",
    axis.title = element_text(color = "#28a87d"),
    axis.text = element_text(color = "#28a87d"),
    axis.ticks = element_line(color = "#28a87d"))


# ggtext ------------------------------------------------------------------
library(ggtext)
p_penguins_scatter +
  labs(title = "**ペンギンの体の大きさの関係**",
       x = "*Flipper length* (mm)",
       y = "*Bill length* (mm)") +
  theme(
    plot.title = ggtext::element_markdown(
      color = custom_pals[4],
      fill = "gray80"
    ),
    axis.title.x = element_markdown(),
    axis.title.y = element_markdown())

# gghighlight -------------------------------------------------------------
library(gghighlight)
p_penguins_scatter +
  gghighlight(species == "Adelie")

# ggrepel -----------------------------------------------------------------
library(ggrepel)
p_gapminder <-
  gapminder::gapminder |>
  filter(year == 2007,
         continent == "Americas") |>
  ggplot() +
  aes(gdpPercap, lifeExp) +
  geom_point()

p_gapminder +
  ggrepel::geom_text_repel(
    aes(label = country))

p_gapminder +
  gghighlight::gghighlight(
    lifeExp < 70) +
  ggrepel::geom_text_repel(
    aes(label = country))

p_penguins_scatter +
  geom_text_repel(aes(label = island),
                  max.overlaps = 1,
                  max.time = 10)

p_penguins_scatter$data |>
  count(island)


# patchwork ---------------------------------------------------------------





# 地理空間情報を利用できる場合の地図表現 -----------------------------------------------------
library(sf)
library(dplyr, warn.conflicts = FALSE)
ne_jpn <-
  # パブリックドメインで利用可能な日本の都道府県行政区域のデータ
  rnaturalearth::ne_states(country = "Japan", returnclass = "sf") |>
  arrange(iso_3166_2) |>
  select(!region) |>
  mutate(iso_3166_2 = stringr::str_remove(iso_3166_2, "JP-")) |>
  #
  left_join(zipangu::jpnprefs |>
              select(jis_code, prefecture = prefecture_kanji, region),
            by = c("iso_3166_2" = "jis_code")) |>
  select(iso_3166_2, prefecture, region)
ne_jpn

sf_jpn_population <-
  ne_jpn |>
  left_join(df_ssdse_b |>
              select(prefecture, year, population),
            by = "prefecture")

p <-
  ne_jpn |>
  ggplot() +
  aes() +
  geom_sf()
p +
  theme_void()

# sf_jpn_population |>
#   filter(year == 2019) |>
#   select(!year) |>
#   st_drop_geometry() |>
#   slice_head(n = 15) |>
#   gt::gt() |>
#   gt::gtsave("out.png")
sf_jpn_population |>
  filter(year == 2019) |>
  ggplot() +
  aes(fill = population) |>
  geom_sf(color = "transparent", show.legend = FALSE) +
  scale_fill_viridis_c() +
  theme_void()

# Rで地図を作る -----------------------------------------------------------------
ne_jpn |>
  ggplot() +
  aes() +
  geom_sf()

ne_jpn |>
  ggplot() +
  aes(fill = prefecture) +
  geom_sf(show.legend = FALSE)

# 地理空間情報をもつデータのfacet ------------------------------------------------------
sf_jpn_population |>
  filter_shikoku() |>
  ggplot() +
  aes(fill = population) +
  geom_sf(color = "transparent") +
  guides(fill = guide_colorbar(title = "総人口")) +
  scico::scale_fill_scico(palette = "imola",
                          labels = zipangu::label_kansuji(),
                          breaks = c(700000, 1000000, 1400000)) +
  labs(title = "四国4県の人口",
       subtitle = "2008年から2019年の推移",
       caption = "Source: 統計センター 教育用標準データセット\nSSDSE-県別推移（SSDSE-B）") +
  theme_void() +
  theme(legend.position = "top",
        legend.key.width = unit(3.0, "line")) +
  facet_wrap(~ year, nrow = 2)


# 地図投影法の変換 ----------------------------------------------------------------
# Natural Earthから全球ポリゴンを取得
ne_world <-
  rnaturalearth::ne_countries(scale = 10,
                              returnclass = "sf")
p <-
  ne_world |>
  ggplot() +
  geom_sf()

# 座標参照系を確認 (地理座標系, WGS84)
sf::st_crs(ne_world)$input

# モルワイデ図法による世界地図の描画
p +
  coord_sf(crs = "+proj=moll")

# st_transform()による座標参照系の変更
ne_world_moll <-
  sf::st_transform(ne_world, crs = "+proj=moll")

ggplot(data = ne_world_moll) +
  geom_sf()


# 必要に応じて名寄せや集計単位を変更する -----------------------------------------------------
ne_jpn_region <-
  ne_jpn |>
  group_by(region) |>
  summarise()
ne_jpn_region |>
  ggplot() +
  geom_sf()

df_region_pops_2019 <-
  df_pops_2019 |>
  left_join(zipangu::jpnprefs |>
              select(prefecture = prefecture_kanji, region),
            by = "prefecture") |>
  group_by(region) |>
  summarise(population = sum(population))

ne_jpn_region |>
  left_join(df_region_pops_2019,
            by = "region") |>
  ggplot() +
  aes(fill = population) +
  geom_sf(color = "transparent")



# 地図を使わない表現 ---------------------------------------------------------------
library(statebins)
election_2012 <-
  suppressMessages(readr::read_csv(system.file("extdata", "election2012.csv", package = "statebins")))
election_2012 |>
  mutate(value = if_else(is.na(Obama), "Romney", "Obama")) %>%
  statebins(
    font_size=4, dark_label = "white", light_label = "white",
    ggplot2_scale_function = scale_fill_manual,
    name = "Winner",
    values = c(Romney = "#2166ac", Obama = "#b2182b")
  ) +
  theme_statebins()

reprex::reprex({

}, venue = "rtf")

# tabularmaps -------------------------------------------------------------
library(tabularmaps)
jpn77 |>
  select(jis_code,
         prefecture = prefecture_kanji,
         x,
         y) |>
  left_join(df_ssdse_b2019,
            by = "prefecture") |>
  tabularmap(x,
             y,
             group = jis_code,
             label = prefecture,
             fill = population,
             size = 3) +
  scale_fill_viridis_c() +
  theme_tabularmap()


# geofacet ----------------------------------------------------------------
library(geofacet)
jp_prefs_grid1 <-
  jp_prefs_grid1 |>
  left_join(
    zipangu::jpnprefs |>
      select(jis_code, prefecture = prefecture_kanji),
    by = c("code_pref_jis" = "jis_code"))
p <-
  df_ssdse_b |>
  ggplot() +
  aes(year, population) +
  geom_line() +
  theme_gray(base_size = 6)
# p +
#   facet_wrap(~ prefecture, scales = "free_y")

p +
  facet_geo(~ prefecture,
          grid = "jp_prefs_grid1",
          scales = "free_y")

