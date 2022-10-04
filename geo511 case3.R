library(ggplot2)
library(gapminder)
library(dplyr)
data(gapminder)
gapminder2 = filter(gapminder,country != "Kuwait")
head(gapminder2)
glimpse(gapminder2)
ggplot(gapminder2) + geom_point(aes(x = lifeExp, y = gdpPercap, size=pop/100000, color = continent)) + facet_wrap(~year, nrow = 1) + scale_y_sqrt() + theme_bw() + labs(x = "Life Expectancy", y = "GDP per capita", size = "Population (100k)", color = "Continent", title = "Weather and life expectancy through time") + theme(axis.text.x = element_text(size = 12),axis.text.y = element_text(size = 12),title = element_text(size = 18))
ggsave(
  filename = "Plot1 .png", 
  width = 17,         
  height = 9,           
  units = "in", 
  dpi = 300 )
gapminder3 = gapminder2 %>% 
  group_by(continent, year) %>% 
  summarise(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), 
            pop = sum(as.numeric(pop)))
# gapminder3 = summarise(group_by(gapminder2,continent, year),gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), 
#                    pop = sum(as.numeric(pop)))
ggplot(gapminder2) + geom_line(aes(x = year, y = gdpPercap, color = continent, group = country)) + geom_point(aes(x = year, y = gdpPercap, color = continent, group = country)) + geom_point(data = gapminder3, aes(x = year, y = gdpPercapweighted, size = pop/100000)) + geom_line(data = gapminder3, aes(x = year, y = gdpPercapweighted)) + facet_wrap(~continent, nrow = 1) + theme_bw() + labs(x = "Year", y = "GDP per capita", size = "Population (100k)", color = "Continent") + theme(axis.text.x = element_text(size = 12),axis.text.y = element_text(size = 12),title = element_text(size = 18))
ggsave(
  filename = "Plot2 .png", 
  width = 24,             
  height = 7,            
  units = "in",          
  dpi = 300             
)

