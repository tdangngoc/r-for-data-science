install.packages("tidyverse")
install.packages("mapproj")
library(tidyverse)
install.packages(c("nycflights13", "gapminder", "Lahman"))

# Data visualisation : first steps


ggplot2::ggplot()
?mpg
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))


# Exercices

# 1. Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)
# We don't see anything

# 2. How many rows are in mpg? How many columns?

mpg
# There is 234 observations and 11 columns

# 3. What does the drv variable describe? Read the help for ?mpg to find out.

?mpg
# The drv variable describe the wheel drive's type for a car

# 4. Make a scatterplot of hwy vs cyl.

ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))
# The plot shows a negative regression, which means that a car with a low cylinder 
# consume more fuel than a higher cylinder for a long distance

# 5. What happens if you make a scatterplot of class vs drv? Why is the plot not useful?

ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = drv))
# This plot is not useful because there is no relation with fuel consumption


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))


# Exercices

# 1. What’s gone wrong with this code? Why are the points not blue?

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
# The parenthesis in the geom_point function is incorrectly placed. That is why the
# parameter color hasn't been applied on the plot.

# 2. Which variables in mpg are categorical? Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?

str(mpg)
# Categorical variables are : manufacturer, model, trans, drv, fl and class
# Continuous varibales are : displ, year, cyl,cty, hwy
# You can see these information according to their types.

# 3. Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = cty))
# For the two first plots, we can observed that the legend is a scale for 
# continuous variables. But the last plot cannot be plot because we cannot
# use shape parameter for continuous variables.

# 4. What happens if you map the same variable to multiple aesthetics?

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = displ, color = displ))
# We obtain a linear line

# 5. What does the stroke aesthetic do? What shapes does it work with? 
# (Hint: use ?geom_point)

?geom_point
# The stroke aesthetic allowsto modify the width of the border.
# Stroke aesthetic can only be applied on shapes that have borders

# 6. What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)? 
# Note, you’ll also need to specify x and y.

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
# This will apply different color on displ according to the condition.


ggplot(data = mpg) + 
geom_point(mapping = aes(x = displ, y = hwy)) +
facet_wrap(~class, nrow = 2)
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~cyl)

# Exercices

# 1.What happens if you facet on a continuous variable?

ggplot(data=mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~cty)
# If we facet a continuous variable, It will separate every value of the continuous
# variable into a cell.

# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?

# The empty cells in plot means that there is no value that correspond to
# any of these 2 variables

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
# Each point on this plot means that there is values between 2 variables.
# And we can clearly see the similarity with the previous plot with facet.

# 3. What plots does the following code make? What does . do?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
# This code shows a plot of only one facet for the row

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# This code shows a plot of only one facet for the column

# If we just need to have one facet either for the row or the column, we replace
# the variable name by a dot.

# 4. What are the advantages to using faceting instead of the colour aesthetic? 
# What are the disadvantages? How might the balance change if you had a larger dataset?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# Using faceting is useful when we have several values in a categorical variable.
# This will clearly separate each value into different cell and allows to better
# analyze data.
# Faceting is not efficient when there is few data available
# If we had a larger dataset, faceting could be interesting to use because the more
# we have values, the more data analysis would be efficient.

# 5. Read ?facet_wrap. What does nrow do? What does ncol do? 
# What other options control the layout of the individual panels? 
# Why doesn’t facet_grid() have nrow and ncol arguments?

?facet_wrap
# nrow allows to define the number of row we want to be plotted
# ncol allows to define the number of column we want to be plotted
# scales and shrink seem to control the layout of the individual panels

?facet_grid
# facet_grid() define the number of column and row according to the number of values in a variable 

# 6. When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?

# For a question of visibility, it is better to put the variable with more unique levels in the column

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
  )

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


# Exercices

# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?

# To draw a line chart, we use geom_line
# To draw a boxplot, we use geom_boxplot
# To draw a histogram, we use geom_histogram
# To draw an area chart, we use geom_area

# 2. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3. What does show.legend = FALSE do? What happens if you remove it?
# Why do you think I used it earlier in the chapter?

# show.legend = FALSE remove the legend beside the plot. If we remove it,
# then the legend appears beside the plot.
# It has been removed to compare with the two first plots, which does not have legend

# 4. What does the se argument to geom_smooth() do?

?geom_smooth
# It displays the confidence interval around smooth

# 5. Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These 2 plots are similar. We pass the global mapping into the ggplot function
# so each geom can have the same mapping

# 6. Recreate the R code necessary to generate the following graphs.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(line = drv),se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv),se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, fill = drv)) +
  geom_point(shape = 21, color = "white", size = 2, stroke = 2)


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

?geom_bar

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# Exercises

# 1. What is the default geom associated with stat_summary()? 
# How could you rewrite the previous plot to use that geom function instead of the stat function?

?stat_summary
# The default geom associated with stat_summary is pointrange

ggplot(data = diamonds) + 
  geom_pointrange(mapping = aes(x = cut, y = depth),
                                stat = "summary",
                                fun.ymin = min,
                                fun.ymax = max,
                                fun.y = median)

# 2. What does geom_col() do? How is it different to geom_bar()?

?geom_col
#geom_col() represents heights of the bars the values in the data whereas geom_bar()
# represents heights of the bar proportional to the number of cases of each group

# 3. Most geoms and stats come in pairs that are almost always used in concert. 
#Read through the documentation and make a list of all the pairs. What do they have in common?

# There are more than 10 pairs between geom and stat. Most of the time, geom and stat have the same name

# 4. What variables does stat_smooth() compute? What parameters control its behaviour?

?stat_smooth
# stat_smooth() compute predicted values (y),  
# lower pointwise confidence interval around the mean (ymin),
# upper pointwise confidence interval around the mean (ymax),
# and standard error (se)
# Parameters that control its behaviour are ymin, ymax and se

# 5. In our proportion bar chart, we need to set group = 1. Why? 
# In other words what is the problem with these two graphs?

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))

# We need to group by cut if we want to plot like the previous plots. Doing that allow to
# considered separately each level of cut.


ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# Exercises

# 1. What is the problem with this plot? How could you improve it?

str(mpg)

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
# Based on the number of observations in the mpg data, we can see that not all
# the points are plotted because of the overplotting.

# The solution is to add some random noises points with jitter
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

# 2. What parameters to geom_jitter() control the amount of jittering?

?geom_jitter

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter(width = 10, height = 10)
# If we change the width and height parameters, we can clearly see that the amount
# of points changes.

# 3. Compare and contrast geom_jitter() with geom_count()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
# The difference between geom_jitter() and geom_count() comes from the representation
# of points density in function of the location.
# geom_count seems to be more interesting for a general representation than geom_jitter()

# 4. What’s the default position adjustment for geom_boxplot()? 
# Create a visualisation of the mpg dataset that demonstrates it.

?geom_boxplot
# The default position adjustment for geom_boxplot() is the position_dodge

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))
# As we can see, each box is separated, which is typically a position_dodge


ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = hwy))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = hwy)) +
  coord_flip()

nz <- map_data("nz")
ggplot(data = nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut),show.legend = FALSE, width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()


# Exercises 

# 1. Turn a stacked bar chart into a pie chart using coord_polar()

bar2 <- ggplot(data = mpg, mapping = aes(x = drv, fill = drv)) +
  geom_bar(show.legend = FALSE, width =1) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar2 + coord_polar()

# 2. What does labs() do? Read the documentation.

?labs
# The function lab is useful to add some information about the graph,
# especially title, axis legends.

# 3. What’s the difference between coord_quickmap() and coord_map()?

?coord_quickmap
# coord_quickmap is used to preserve straight lines of a map whereas
# coord_map() is used to plot a portion of the earth

# 4. What does the plot below tell you about the relationship between city and highway mpg? 
# Why is coord_fixed() important? 
# What does geom_abline() do?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  geom_abline() + 
  coord_fixed()
# It looks like city is correlated to highway mpg 

?coord_fixed
# coord_fixed is important because it keeps a ratio between x axis and y axis
# When we plot a graph, sometimes the ratio is incorrect, so we can recover this 
# issue through this function.
?geom_abline
# geom_abline is a line reference to annotate a plot. This can be useful to show if
# two variables are related or not.


# An useful template to plat graphics for data visualisation

"
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
"
