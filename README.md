Rによるデータ可視化と地図表現
========================

2022年度 統計思考院ワークショップ「探索的ビッグデータ解析と再現可能研究」における
プログラムの一つである「Rによるデータ可視化と地図表現」の資料置き場です。

## 予習

### R環境

- R (v4.2.1), RStduio

#### パッケージのインストール

次のコマンドを実行することで利用するパッケージをインストールできます。

```r
packages <- c(
 "tidyverse", "sf", "zipangu", "tabularmaps", "geofacet",
 "palmerpenguins", "datasauRus", "gt", "gapminder", "statebins",
 "ggtext", "ggrepel", "gghighlight", "patchwork",
 "rnaturalearth", "ggokabeito")
install.packages(setdiff(packages, rownames(installed.packages())))

ropensci_pkgs <- c("rnaturalearthhires")
install.packages(setdiff(ropensci_pkgs, rownames(installed.packages())), 
                 repos = "https://ropensci.r-universe.dev")

wilkelab_pkgs <- c("gridtext")
install.packages(setdiff(wilkelab_pkgs, rownames(installed.packages())), 
                 repos = "https://wilkelab.r-universe.dev")

uris_pkgs <- c("ssdse")
install.packages(setdiff(uris_pkgs, rownames(installed.packages())), 
                 repos = "https://uribo.r-universe.dev")
```
