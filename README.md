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
 "tidyverse", "sf", "mapview", "zipangu", "tabularmaps", "geofacet",
 "ggtext", "ggrepel", "gghighlight", "biscale", "patchwork",
 "cartogram", "tmap")
 
install.packages(setdiff(packages, rownames(installed.packages())))

uris_packages <- c(
  "jmastats", "ssdse", "suryulib")
install.packages(setdiff(uris_packages, rownames(installed.packages())), 
                 repos = "https://uribo.r-universe.dev")
```
