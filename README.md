# R Basics：Apply家族

## apply 家族
apply 家族位在 R 內建的 base 裡面，不需要額外安裝 package

* apply()：apply(X, MARGIN, FUN, ...)
  * apply 的用法是將一個函數 FUN 套用在指定的資料集 X 中的每個元素上，透過 MARGIN 參數來指定函數 FUN 是要依照列 (by row = 1) 還是欄 (by column = 2) 來執行
```
data <- array(1:50, c(5, 10))
apply(data, 2, function(a)sum(a^2))                       # 每一欄的平方和
apply(data, 1, function(x) length(x[x %% 7 == 0]))        # 被 7 整除的數字個數

x <- cbind(x1=3, x2=c(4:1, 2:5))
myFUN <- function(x, c1, c2) {
          c(sum(x[c1], 1), mean(x[c2])) 
}
# 把數據框按行做循環，每行分別傳遞給 myFUN 函數，設置 c1,c2 對應 myFUN 的第二、三個參數
apply(x, 1, myFUN, c1='x1', c2=c('x1','x2'))
```
> [1]    55   330   855  1630  2655  3930  5455  7230  9255 11530 <br>
> [1] 1 2 1 2 1 <br>
> <br>
>      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]  <br>
> [1,]  4.0    4  4.0    4  4.0    4  4.0    4  <br>
> [2,]  3.5    3  2.5    2  2.5    3  3.5    4  <br>
<br>

* lapply()：lapply(X, FUN, ...)
  * 透過 lapply 函數操作完之後，會回傳一個 list
  * 在 lapply 當中不能指定要 by row 還是 by column，會逐個項目去運算，所以這裡的資料 X 通常會放一維的 vector，在操作上會比較清楚
```
EX1 <- lapply(1:3, function(x)x^x)                        # x 的 x 次方

x <- cbind(x1=3, x2=c(2:1,4:5))
class(x)
lapply(x, sum)

lapply(data.frame(x), sum)
```
> [1] "matrix" "array" <br>
> <br>
> [[1]]  [1] 3 <br> 
> [[2]]  [1] 3 <br>
> [[3]]  [1] 3 <br>
> [[4]]  [1] 3 <br>
> [[5]]  [1] 2 <br>
> [[6]]  [1] 1 <br>
> [[7]]  [1] 4 <br>
> [[8]]  [1] 5 <br>
> <br>
> $x1 [1] 12 <br>
> $x2 [1] 12 <br>
<br>

* sapply()：sapply(X, FUN, ..., simplify=TRUE, USE.NAMES=TRUE)
  * 透過函數 sapply 回傳的結果是將 list 形式簡單化 (simplified) 後的 vector
  * sapply 在功能上與 lapply 基本上是一樣的，都是餵給一個 list，然後依據後面指定的功能函數來一項一項做運算， 不過跟 lapply 不同的是，sapply 會回傳一個 vector
  * 如果 simplify=FALSE 和 USE.NAMES=FALSE，sapply 完全等於 lapply
```
data2 <- data.frame(height = c(157, 172, 168),
                    weight = c(53, 70, 61))
sapply(data2, mean)
```
>    height    weight <br> 
> 165.66667  61.33333 <br> 
```
a <- 1:2
sapply(a, function(x) matrix(x,2,2), simplify='array')

sapply(a, function(x) matrix(x,2,2))
```
>  , , 1          <br>
>      [,1] [,2]  <br>
> [1,]    1    1  <br>
> [2,]    1    1  <br>
>  , , 2          <br>
>      [,1] [,2]  <br>
> [1,]    2    2  <br>
> [2,]    2    2  <br>
> <br>
>       [,1] [,2] <br>
> [1,]    1    2  <br>
> [2,]    1    2  <br>
> [3,]    1    2  <br>
> [4,]    1    2  <br>
<br>

* mapply()：mapply(FUN, ..., MoreArgs=NULL, SIMPLIFY=TRUE, USE.NAMES=TRUE)
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
> [1]  5  4  3  4  5  6  7  8  9 10 <br>
<br>

* vapply()：vapply(X, FUN, FUN.VALUE, ..., USE.NAMES=TRUE)
  * vapply 類似於 sapply，提供 FUN.VALUE 參數，用來控制返回值的行名
```
x <- data.frame(cbind(x1=3, x2=c(2:1,4:5)))
vapply(x, cumsum, FUN.VALUE=c('a'=0, 'b'=0, 'c'=0, 'd'=0))

a <- sapply(x, cumsum)
row.names(a) <- c('a', 'b', 'c', 'd')
```
>    x1 x2 <br>
>  a  3  2 <br>
>  b  6  3 <br>
>  c  9  7 <br>
>  d 12 12 <br>
<br>

* tapply()：tapply(X, INDEX, FUN=NULL, ..., simplify=TRUE)
```
x <- y <- 1:10
# 設置分組索引t
t <- round(runif(10,1,100)%%2)
tapply(x, t, sum)

# 對於 t=0 時，x=8 再加上 y=55，最後計算結果為 63
tapply(x, t, sum, y)
```
>    0  1  2  <br>
>   15 30 10  <br>
> <br>
>    0  1  2  <br> 
>   70 85 65  <br>
<br>

* rapply()：rapply(object, f, classes="ANY", deflt=NULL, how=c("unlist", "replace", "list"), ...)
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
>  $x                  <br> 
>  $x$a  [1] 12        <br> 
>  $x$b  [1] 1 2 3 4   <br> 
>  $x$c  [1] "b" "a"   <br> 
>  $y                  <br> 
>  [1] 3.141593        <br> 
>  $z                  <br> 
>               a  b   <br> 
>  1  -2.21469989  1   <br> 
>  2  -0.62124058  2   <br> 
>  3  -0.04493361  3   <br> 
>  4  -0.01619026  4   <br> 
>  5   0.38984324  5   <br> 
>  6   0.59390132  6   <br> 
>  7   0.82122120  7   <br> 
>  8   0.94383621  8   <br> 
>  9   1.12493092  9   <br> 
>  10  1.51178117 10   <br> 
> <br>
> $x                   <br> 
> $x$a  [1] NA         <br> 
> $x$b  [1] NA         <br> 
> $x$c  [1] "b++++" "a++++"    <br> 
> $y    [1] NA         <br>
> $z                   <br>
> $z$a  [1] NA         <br>
> $z$b  [1] NA         <br>
<br>

* eapply()：eapply(env, FUN, ..., all.names=FALSE, USE.NAMES=TRUE)
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
> [1] "a"     "beta"  "logic" <br>
> <br>
> a :  int [1:10] 1 2 3 4 5 6 7 8 9 10                   <br>
> beta :  num [1:7] 0.0498 0.1353 0.3679 1 2.7183 ...    <br>
> logic :  logi [1:4] TRUE FALSE FALSE TRUE              <br>
> $a      [1] 5.5                                        <br>
> $logic  [1] 0.5                                        <br>
> $beta   [1] 4.535125                                   <br>
> <br>
> $t             176 bytes   <br>
> $mean.1         56 bytes   <br>
> $mice.data   71480 bytes   <br>
> $x             736 bytes   <br>
> $y              56 bytes   <br>
> $z            1024 bytes   <br>
> $env            56 bytes   <br>
> $a            2256 bytes   <br>
> $EX1           248 bytes   <br>
> $mice_plot   11928 bytes   <br>
> $na.rows       648 bytes   <br>
> $iris         7256 bytes   <br>
> $mean.data    7256 bytes   <br>
> $myFUN       13672 bytes   <br>
> $data          416 bytes   <br>
> $imputeData   7256 bytes   <br>
> $data2         912 bytes   <br>
<br>

## 圖示
![apply家族](https://github.com/sueshow/R_Basics/blob/main/picture/apply.png)

## 比較
* 從 CPU 的耗時來看，用 for 的計算最耗時，apply 耗時很短，而直接使用内置的向量計算的操作幾乎不耗時。通過上面的測試，優先考虑内置的向量計算，必须要用到循環計算時則使用 apply，應該盡量避免使用 for, while 等操作方法。
```
# 封裝fun1
fun1 <- function(x){
                     myFUN <- function(x, c1, c2){
                                                   c(sum(x[c1],1), mean(x[c2])) 
                                                 }
                     apply(x,1,myFUN,c1='x1',c2=c('x1','x2'))
                   }

# 封裝fun2
fun2 <- function(x){
                     df<-data.frame()
                     for(i in 1:nrow(x)){
                                          row<-x[i,]
                                          df<-rbind(df,rbind(c(sum(row[1],1), mean(row))))
                                        }
                   }

# 封裝fun3
fun3 <- function(x){
                     data.frame(x1=x[,1]+1,x2=rowMeans(x))
                   }

# 生成數據集
x <- cbind(x1=3, x2=c(400:1, 2:500))

# 分別統計 CPU 耗時
system.time(fun1(x))

system.time(fun2(x))

system.time(fun3(x))
```
>    user  system elapsed <br>
>    0.02    0.00    0.01 <br>
> <br>
>    user  system elapsed <br>
>    0.16    0.00    0.16 <br> 
> <br>
>    user  system elapsed <br>
>       0       0       0 <br>
<br>

* 如果 simplify=FALSE 和 USE.NAMES=FALSE，sapply 完全等於 lapply
```
x <- cbind(x1=3, x2=c(2:1,4:5))
lapply(data.frame(x), sum)
sapply(data.frame(x), sum, simplify=FALSE, USE.NAMES=FALSE)
```
>  $x1   [1] 12  <br>
>  $x2   [1] 12  <br>
<br>

## 參考資訊
* https://kemushi54.github.io/R-basic/apply_family.html
* http://blog.fens.me/r-apply/
