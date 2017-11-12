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