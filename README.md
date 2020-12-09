# R_Basics

## apply 家族
apply 家族位在 R 內建的 base 裡面
```
```

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
```
```

* mapply()：mapply(FUN, …)
  * 可以同時使用多個變數
```
```

