library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization
library(purrr)
library(LICORS)

df <- USArrests
df <- na.omit(df)
df <- scale(df)
head(df)
distance <- get_dist(df)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
k2 <- kmeanspp(df, k = 2, nstart = 25)
str(k2)
fviz_cluster(k2, data = df)
k3 <- kmeanspp(df, k = 3, nstart = 25)
k4 <- kmeanspp(df, k = 4, nstart = 25)
k5 <- kmeanspp(df, k = 5, nstart = 25)

# plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = df) + ggtitle("k = 5")

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)

set.seed(123)

# function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeanspp(df, k, nstart = 10 )$tot.withinss
}

# Compute and plot wss for k = 1 to k = 15
k.values <- 1:15

# extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)

plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")


set.seed(123)
final <- kmeanspp(df, 4, nstart = 25)
print(final)

fviz_cluster(final, data = df)
