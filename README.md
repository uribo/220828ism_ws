Rによるデータ可視化と地図表現
========================

2022年度 統計思考院ワークショップ「[探索的ビッグデータ解析と再現可能研究](https://sites.google.com/view/ws-ebda-rr-2022/)」における
プログラムの一つである「Rによるデータ可視化と地図表現」の資料置き場です。

## スライド

当日投影したスライドの公開版をSpeaker Deckで公開しています。

http://speakerdeck.com/s_uryu/rniyorudetake-shi-hua-todi-tu-biao-xian

[![スライドへのリンク](images/slide_top.jpeg)](http://speakerdeck.com/s_uryu/rniyorudetake-shi-hua-todi-tu-biao-xian)

## 予習

### R環境

- R (v4.2.1), RStudio

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
