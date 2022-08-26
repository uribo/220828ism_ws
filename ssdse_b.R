# install.packages("ssdse", repos = "https://uribo.r-universe.dev")
df_ssdse_b <-
  ssdse::read_ssdse_b("https://www.nstac.go.jp/sys/files//SSDSE-B-2022.csv",
                    lang = "ja",
                    pack = TRUE) |>
  dplyr::select(prefecture = `都道府県`,
         year = `年度`,
         `人口・世帯`,
         `自然環境`,
         `家計`) |>
  tidyr::unnest(everything()) |>
  dplyr::select(prefecture, year,
                population = `総人口`,
                birth_male = `出生数（男）`,
                birth_female = `出生数（女）`,
                # temperature = `年平均気温`,
                # precipitation = `降水量（年間）`,
                spending = `消費支出（二人以上の世帯）`,
                food_expenses = `食料費（二人以上の世帯）`)

# pins::board_register_github(repo = "uribo/220828ism_ws")
# pins::pin(df_ssdse_b, description = "SSDSE(教育用標準データセット)を一部加工したもの", board = "github")

# base <- "https://raw.githubusercontent.com/uribo/220828ism_ws/main/"
# board <- pins::board_url(
#   c(raw = paste0(base, "df-ssdse-b/data.rds")))
# readr::read_rds(board %>% pin_download("raw"))

