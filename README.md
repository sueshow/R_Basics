# R Basics

## apply 家族
apply 家族位在 R 內建的 base 裡面，不需要額外安裝 package

* apply()：apply(X, MARGIN, FUN, …)
  * apply 的用法是將一個函數 FUN 套用在指定的資料集 X 中的每個元素上，透過 MARGIN 參數來指定函數 FUN 是要依照列 (by row = 1) 還是欄 (by column = 2) 來執行
```
data <- array(1:50, c(5, 10))
apply(data, 2, function(a)sum(a^2))                       # 每一欄的平方和
apply(data, 1, function(x) length(x[x %% 7 == 0]))        # 被 7 整除的數字個數
```

* lapply()：lapply(X, FUN, …)
  * 透過 lapply 函數操作完之後，會回傳一個 list
  * 在 lapply 當中不能指定要 by row 還是 by column，會逐個項目去運算，所以這裡的資料 X 通常會放一維的 vector，在操作上會比較清楚
```
EX1 <- lapply(1:3, function(x)x^x)                        # x 的 x 次方
```

* sapply()：sapply(X, FUN, …)
  * 透過函數 sapply 回傳的結果是將 list 形式簡單化 (simplified) 後的 vector
  * sapply 在功能上與 lapply 基本上是一樣的，都是餵給一個 list，然後依據後面指定的功能函數來一項一項做運算， 不過跟 lapply 不同的是，sapply 會回傳一個 vector
```
data2 <- data.frame(height = c(157, 172, 168),
                    weight = c(53, 70, 61))
sapply(data2, mean)
```

* mapply()：mapply(FUN, …)
  * 可以同時使用多個變數
  * 在 mapply 中，運算函數放前，list 在後。假設今天給 mapply 三個 list{a, b, c}，mapply 會分別取三個 list 的第一項去做第一次運算，然後換三個 list 的第二項去做第二次運算…依此類推
```
set.seed(1)
x <- 1:10
y <- 5:-4
z <- round(runif(10, -5, 5))
# 按索引順序取較大的值
mapply(max, x, y, z)
```

* vapply()：vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
  * 
```
x <- data.frame(cbind(x1=3, x2=c(2:1,4:5)))
vapply(x, cumsum, FUN.VALUE=c('a'=0, 'b'=0, 'c'=0, 'd'=0))
a <- sapply(x, cumsum)
row.names(a) <- c('a', 'b', 'c', 'd')
```

* tapply()：tapply(X, INDEX, FUN = NULL, ..., simplify = TRUE)
  * 
```
x <- y <- 1:10
# 設置分組索引t
t <- round(runif(10,1,100)%%2)
tapply(x, t, sum)
# 對於 t=0 時，x=8 再加上 y=55，最後計算結果為 63
tapply(x, t, sum, y)
```
 
* rapply()：rapply(object, f, classes = "ANY", deflt = NULL, how = c("unlist", "replace", "list"), ...)
  * 
```
x <- list(a=12, b=1:4, c=c('b','a'))
y <- pi
z <- data.frame(a=rnorm(10), b=1:10)
a <- list(x=x, y=y, z=z)
# 對一個 list 的數據進行過濾，把所有數字型進行排序
rapply(a, sort, classes='numeric', how='replace')
# 把所有字串型加上'++++'
rapply(a, function(x) paste0(x,'++++'), classes='character', deflt=NA, how='list')
```

* eapply()：eapply(env, FUN, ..., all.names = FALSE, USE.NAMES = TRUE)
  * 
```
env <- new.env()
env$a <- 1:10
env$beta <- exp(-3:3)
env$logic <- c(TRUE, FALSE, FALSE, TRUE)
env
ls(env)
ls.str(env)
# 計算 env 環境空間中所有變量的均值
eapply(env, mean)
# 查看所有變數的占用內存大小
eapply(environment(), object.size)
```

## 圖示
![apply家族](https://github.com/sueshow/R_Basics/blob/main/picture/apply.png)

## 參考資訊
* https://kemushi54.github.io/R-basic/apply_family.html
