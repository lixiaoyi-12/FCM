library(UpSetR)
input <- c("Hummingbirds"=5080,"Parrots"=3060,"Songbirds"=5273,"Hummingbirds&Parrots"=217,"Hummingbirds&Songbirds"=655,"Parrots&Songbirds"=326,"Hummingbirds&Parrots&Songbirds"=84)
data <- fromExpression(input)
upset(data)
upset(data,text.scale = 1.5,sets = c("Hummingbirds","Parrots","Songbirds"),keep.order=TRUE)

