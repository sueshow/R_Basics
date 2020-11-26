# 取代迴圈的 apply 家族

library(data.table)
library(magrittr)

data <- array(1:50, c(5, 10))
data


## apply(X, MARGIN, FUN, …)
# 計算上面資料每一列(by row)的加總
apply(data, 1, sum)   

# 計算上面矩陣每一欄(by column)的平方和
apply(data, 2, function(a) sum(a^2))

# 每一列可以被 7 整除的數字有幾個
apply(data, 1, function(x) length(x[x %% 7 == 0]))

#
x <- cbind(x1=3, x2=c(4:1, 2:5))
x
myFUN<- function(x, c1, c2) {
          c(sum(x[c1], 1), mean(x[c2])) 
}
# 把數據框按行做循環，每行分別傳遞給 myFUN 函數，設置 c1,c2 對應 myFUN 的第二、三個參數
apply(x, 1, myFUN, c1='x1', c2=c('x1','x2'))



## lapply(X, FUN, …)：這裡的資料 X 通常會放一維的 vector，回傳 list
# 計算 1 到 3 每個數字 x 的 x 次方
EX1 <- lapply(1:3, function(x) x^x)
EX1
# EX1的屬性
class(EX1)
# EX1內第一項的屬性
class(EX1[1])
# EX1內第一項裡面的第一項的屬性
class(EX1[[1]])

x <- list(a=1:10, b=rnorm(6,10,5), c=c(TRUE,FALSE,FALSE,TRUE))
# 計算每個 KEY 對應該的數據分位數
lapply(x, fivenum)

x <- cbind(x1=3, x2=c(2:1,4:5))
class(x)
lapply(x, sum)
lapply(data.frame(x), sum)


## sapply(X, FUN, ..., simplify=TRUE, USE.NAMES = TRUE)：sapply 會回傳 vector
# 計算 1 到 3 每個數字 x 的 x 次方
EX2 <- sapply(1:3, function(x)x^x)
EX2

# 計算每一欄的平均
data2 <- data.frame(height=c(157, 172, 168),
                    weight=c(53, 70, 61))
sapply(data2, mean)

# 對矩陣計算，計算過程同 lapply 函數
x <- cbind(x1=3, x2=c(2:1,4:5))
sapply(x, sum)
sapply(data.frame(x), sum)
# 檢查結果類型
class(lapply(x, sum))   #list
class(sapply(x, sum))   #vector
# simplify=FALSE 和 USE.NAMES=FALSE
lapply(data.frame(x), sum)
sapply(data.frame(x), sum, simplify=FALSE, USE.NAMES=FALSE)

val<-head(letters)
sapply(val, paste, USE.NAMES=TRUE)
sapply(val, paste, USE.NAMES=FALSE)


## vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
x <- data.frame(cbind(x1=3, x2=c(2:1,4:5)))
vapply(x, cumsum, FUN.VALUE=c('a'=0, 'b'=0, 'c'=0, 'd'=0))
a <- sapply(x, cumsum)
row.names(a) <- c('a', 'b', 'c', 'd')


## mapply(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE,USE.NAMES = TRUE)：可以同時指定多個 list
set.seed(1)
x <- 1:10
y <- 5:-4
z <- round(runif(10, -5, 5))
# 按索引順序取較大的值
mapply(max, x, y, z)

n <- rep(4, 4)
# m为均值，v为方差
m <- v <- c(1, 10, 100, 1000)
mapply(rnorm, n, m, v)


## tapply(X, INDEX, FUN = NULL, ..., simplify = TRUE)
# 計算不同品種鳶尾花花瓣長度的均值
tapply(iris$Petal.Length, iris$Species, mean)

x <- y <- 1:10
# 設置分組索引t
t <- round(runif(10,1,100)%%2)
tapply(x, t, sum)
# 對於 t=0 時，x=8 再加上 y=55，最後計算結果為 63
tapply(x, t, sum, y)


# rapply(object, f, classes = "ANY", deflt = NULL, how = c("unlist", "replace", "list"), ...)
x <- list(a=12, b=1:4, c=c('b','a'))
y <- pi
z <- data.frame(a=rnorm(10), b=1:10)
a <- list(x=x, y=y, z=z)
# 對一個 list 的數據進行過濾，把所有數字型進行排序
rapply(a, sort, classes='numeric', how='replace')
# 把所有字串型加上'++++'
rapply(a, function(x) paste0(x,'++++'), classes='character', deflt=NA, how='list')


## eapply(env, FUN, ..., all.names = FALSE, USE.NAMES = TRUE)
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


