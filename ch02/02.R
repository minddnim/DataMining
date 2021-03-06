library(plyr)

# 先頭データの表示
head(airquality)

# subset関数
head(subset(airquality, Month==5))

library(dplyr)

airquality %>% filter(Month==5) %>% head()

# 以下から使用するデータ
head(mtcars)

# 大小関係
head(subset(mtcars, mpg>=20))

head(subset(mtcars, mpg<20))

# 複数条件の指定
mtcars %>% filter(mpg>=20 & cyl>=6) %>% head()

mtcars %>% filter(mpg>=20 | cyl>=6) %>% head()

# 値が含まれているものを抽出
head(subset(mtcars, carb %in% c(1,3)))

# Ozone で昇順
head(arrange(airquality, Ozone))

# Ozone で降順
head(arrange(airquality, desc(Ozone)))

# Ozone で昇順, Solar.Rで降順
head(arrange(airquality, Ozone, desc(Solar.R)))

# 縦に結合
(a <- head(airquality, 3))
(b <- tail(airquality, 3))
(ab <- rbind(a, b))

df <- data.frame(Ozone = 33)
# tail(rbind_all(list(airquality, df))) # rbind_allは使えなくなる関数
tail(bind_rows(list(airquality, df)))

# 横に結合
a <- data.frame(id=1:10, id2=11:20, x=101:110)
b <- data.frame(id=c(1,3,5,11), id2=c(11, 17, 15, 24), y=c(100, 200, 150, 400))

## 内部結合 aとbのidが一致しているもののみ結合
(ab1 <- merge(a, b, by="id"))

## 複数のキーを指定して結合 aとbのidが一致しているもの、かつ、aとbのid2が一致しているものを結合
(ab1_2 <- merge(a, b, by=c("id", "id2")))

## 同じ名前の変数があったときに、変数名の後ろにつける文字の指定
(ab1_3 <- merge(a, b, by="id", suffixes=c(".a", ".b")))

# 左側のデータを全部残す結合 (left join)
(ab2 <- merge(a, b, by="id", all.x=T))

# 右側のデータを全部残す結合 (right join)
(ab3 <- merge(a, b, by="id", all.y=T))

# 全部のデータを残す結合 (full join)
(ab4 <- merge(a, b, by="id", all=T))

# join 関数群は, キーとなる変数の方が厳密に同じでなければならないため、integerで指定してデータを作成
a <- data.frame(id=as.integer(1:10), id2=as.integer(11:20), x = 101:110)

b <- data.frame(id=as.integer(c(1,3,5,11)), id2=as.integer(c(11, 17, 15, 24)), y=c(100, 200, 150, 400))

# 内部結合
ab1 <- inner_join(a, b, by="id")

# 表示
ab1

ab1_2 <- inner_join(a, b, by=c("id", "id2"))

ab1_2

ab2 <- left_join(a, b, by="id", all.x=T)

ab2

library(reshape2)
head(airquality)

# meltを使って、MonthとDayをキーにして列名と値を列挙する
airquality.melt <- melt(airquality, id=c("Month", "Day"))
head(airquality.melt)

# variableとvalueの列名を定義
airquality.melt <- melt(airquality, id=c("Month", "Day"), variable.name="air", value.name="val")
head(airquality.melt)

# サンプル用のデータセットの作成
aqm <- melt(airquality, id = c("Month", "Day"), na.rm = TRUE)

# 各月の平均値を出力
dcast(aqm, Month ~ variable, mean)

dcast(aqm, Month ~ variable, mean, margins = "Month")

dcast(aqm, Month ~ variable, mean, margins = "variable")

dcast(aqm, Month ~ variable, mean, margins = c("Month", "variable"))

dcast(aqm, Month ~ variable, mean, margins = T)

dcast(aqm, Month ~ variable, mean, subset = .(variable == c("Ozone", "Temp")))

head(dcast(aqm, Month + Day ~ variable, mean, subset = .(variable == c("Ozone", "Temp"))))

head(dcast(aqm, Month ~ variable + Day, mean, subset = .(variable == c("Temp"))), n = 3)

head(mtcars)

# 1つの集約変数ごとに平均を求める
mtcars %>% group_by(am) %>% summarise(mpg.mean=mean(mpg))

# amとvsの組み合わせでmpgの平均値を集計
mtcars %>% group_by(am, vs) %>% summarise(mpg.mean=mean(mpg))

mtcars %>% group_by(am,vs) %>% summarise(cyl.max=cyl[which.max(mpg)])

mtcars %>% group_by(am, vs) %>% summarise(mpg.mean=mean(mpg), disp.mean=mean(disp))

mtcars %>% group_by(am, vs) %>% mutate(mpg.mean=mean(mpg), disp.mean=mean(disp)) %>% head()

# データフレームのリストの作成
l <- list(airquality[1:3,], airquality[11:13,], airquality[21:23,])

l

#リストをデータフレームに変換
# df <- rbind_all(l) # これはもう使えなくなる
df <- bind_rows(l) # これからはこの関数を使用

df

library(foreach)

# ここの処理はよく分からない
# date.from <- as.Date("2014-04-01")
# date.to <- as.Date("2014-04-03")
# df2 <- rbind_all(foreach(day=seq.Date(date.from, date.to, "days"), combine=rbind) %do% { f <- sqrintf("aq_%s.csv", day) read.csv(f, header=T, stringsAsFactors=F)})

# df2

aq <- airquality

names(aq)

names(aq)[3] <- "wind"

names(aq)

names(aq)[names(aq)=="Temp"] <- "temp"

names(aq)

# head(rename(airquality, replace= c(Ozone = "Oooozone"))) # これはサポートされていない関数

x <- c("a", "b", "c")

x <- ifelse(x=="a", "AAA", ifelse(x=="c", "CCC", x))

x

x <- c("a", "b", "c")
mapvalues(x, c("a", "c"), c("AAA", "CCC"))

rebalue(x, c(a = "AAA", c = "CCC")

round(135/10)*10

floor(135/ 10)*10

ceiling(135/100)*100

round_any(135, 10)

round_any(135, 10, floor)

round_any(135, 100, ceiling)

d_ply(airquality, .(Month), function(x){month <- x$Month[1] write.csv(x, sprint("airquality_%s.csv", month)) })