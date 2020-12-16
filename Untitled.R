getwd()
setwd("/Users/harish/Downloads/R/Section 6")
getwd()

#------------------------------- Importing data
movies <- read.csv(file.choose())
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "Budget", "Year")
head(movies)
str(movies)

#------------------------------- Factors
movies$Year
factor(movies$Year)
movies$Year <- factor(movies$Year)

factor(movies$Genre)
movies$Genre <- factor(movies$Genre)
str(movies)

#------------------------------- Aesthetics
library(ggplot2)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()

#color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color = Genre)) +
  geom_point()

#size 
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color = Genre,
                        size=Budget)) +
  geom_point()

#------------------------------- Layers
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color = Genre,
                             size=Budget))

p + geom_point()   

#line
p + geom_line() 

#multiplelayers
p + geom_line() + geom_point()
p + geom_point() + geom_line()

#------------------------------- Overriding Aesthetics
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color = Genre,
                             size=Budget))

#overriding
q + geom_point(aes(size=CriticRating))

q + geom_point(aes(color=Budget))

#------------------------------- Mapping vs Setting
r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#add color
#mapping
r + geom_point(aes(color = Genre))
#setting
r + geom_point(color = "DarkGreen")

#------------------------------- Histograms vs Density Charts
s <- ggplot(data=movies, aes(x=Budget))

s + geom_histogram(binwidth = 10)

#add color
s + geom_histogram(binwidth = 10, aes(fill=Genre), color = 'Black')

#density chart
s + geom_density(aes(fill=Genre), color = 'Black')
s + geom_density(aes(fill=Genre), color = 'Black', position = 'Stack')

#------------------------------- Starting layer tips
t <- ggplot(data=movies, aes(x=AudienceRating))

t + geom_histogram(binwidth = 10, fill='White', colour ='Blue')

#Another way
t <- ggplot(data=movies)

t + geom_histogram(binwidth = 10, aes(x=AudienceRating),
                   fill='White', colour ='Blue')

t + geom_histogram(binwidth = 10, aes(x=CriticRating),
                   fill='White', colour ='Blue')

#------------------------------- Statistical transformations
u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             color = Genre))

u + geom_point() + geom_smooth(fill =NA)

#boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating, 
                             color = Genre))

u + geom_boxplot(size = 1.0) + geom_point()

u + geom_jitter() + geom_boxplot(size = 1.0, alpha=0.5) 

#------------------------------- Using Facets
v <- ggplot(data=movies, aes(x=Budget))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour ='Blue') 

#facets

v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour ='Black') + 
  facet_grid(Genre~., scales = 'free')

#scatterplots + facets 

w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             color = Genre))
w + geom_point(size=3) +
  facet_grid(Genre~.)

w + geom_point(size=3) +
  facet_grid(Year~.)

w + geom_point(aes(size=Budget)) +
  geom_smooth() +
  facet_grid(Genre~Year)

#------------------------------- Coordinates
#limits
e <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             size = Budget, color = Genre))

e + geom_point() + 
  xlim(50, 100) +
  ylim(50, 100)

#limiting removes values
f <- ggplot(data=movies, aes(x=Budget))
f + geom_histogram(bandwidth = 10, aes(fill=Genre), colour ="Black") + 
  ylim(0, 50)

#zoom
f + geom_histogram(bandwidth = 10, aes(fill=Genre), colour ="Black") + 
  coord_cartesian(ylim= c(0,50))

#improve scatterplots + facets 
w + geom_point(aes(size=Budget)) +
  geom_smooth() +
  facet_grid(Genre~Year, scales = 'free') +
  coord_cartesian(ylim = c(0,100))

#------------------------------- Theme
g <- ggplot(data=movies, aes(x=Budget))
g + geom_histogram(bandwidth = 10, aes(fill=Genre), colour ="Black")

h <- g + geom_histogram(bandwidth = 10, aes(fill=Genre), colour ="Black")

#axes label
h + 
  xlab("Money axis") + 
  ylab("No of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size  = 19),
        axis.title.y = element_text(colour = "DarkBlue", size  = 19))

#tick mark formatting
h + 
  xlab("Money axis") + 
  ylab("No of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size  = 19),
        axis.title.y = element_text(colour = "DarkBlue", size  = 19),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10))

#legend formatting
h + 
  xlab("Money axis") + 
  ylab("No of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size  = 19, family = "Times New Roman"),
        axis.title.y = element_text(colour = "DarkBlue", size  = 19, family = "Times New Roman"),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        legend.title = element_text(size = 16, family = "Times New Roman"),
        legend.text = element_text(size = 10, family = "Times New Roman"),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour = "Black",
                                  size = 20,
                                  family = "Times New Roman"))


