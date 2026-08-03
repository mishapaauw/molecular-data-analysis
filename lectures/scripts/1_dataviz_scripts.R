library(plotrix)
library(tidyverse)
library(colorspace)

# Inspired by: https://clauswilke.com/dataviz/proportional-ink.html

# Helper function
palette_OkabeIto <- c(
  "#E69F00", "#56B4E9", "#009E73", "#F0E442",
  "#0072B2", "#D55E00", "#CC79A7", "#999999"
)
scale_fill_OkabeIto2 <- function(darken = 0, order = 1:8, alpha = NA, ...) {
  values <- palette_OkabeIto[order]
  n <- length(values)
  darken <- rep_len(darken, n)
  alpha  <- rep_len(alpha, n)
  
  di <- darken > 0
  if (any(di)) values[di] <- colorspace::darken(values[di], amount = darken[di])
  
  li <- darken < 0
  if (any(li)) values[li] <- colorspace::lighten(values[li], amount = -1 * darken[li])
  
  ai <- !is.na(alpha)
  if (any(ai)) values[ai] <- scales::alpha(values[ai], alpha[ai])
  
  ggplot2::scale_fill_manual(values = values, ...)
}
lightened_hex <- colorspace::lighten(palette_OkabeIto, amount = 0.3)

### setup the data (from https://worldpopulationreview.com/cities/netherlands)
populations <- c(1193995, 423526, 105461, 38221, 23619)
cities <- c("Amsterdam", "Utrecht", "Alkmaar", "Wageningen", "Heiloo")

df <- data.frame(county = counties, population = populations)
df$county <- reorder(df$county, df$population)

### 4 visualizations, from bad to good 

# 3D pie chart is the worst option
pie3D(rev(populations), col = lightened_hex, border = "white", height = 0.3, start = 3)

png("pie3d.png", width = 6, height = 6, units = "cm", res = 300)
pie3D(rev(populations), col = lightened_hex, border = "white", height = 0.3, start = 3, mar = rep(1, 4))
dev.off()


# Pie
pie <- ggplot(df, aes(x = "", y = population, fill = county)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  scale_fill_OkabeIto2(darken = -0.3) +
  theme_void() +
  labs(fill = "County")

# Bar
bar <- df %>% ggplot(aes(x = county, y = population)) + 
  geom_bar(aes(fill = county), stat = "identity") + 
  scale_fill_OkabeIto2(darken = -.3, guide = "none") + 
  coord_flip() +
  theme_bw() +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.05)),
    breaks = c(0, 4e5,  8e5, 12e5),
    labels = c("0", "400,000", "800,000",  "1,200,000"),
    name = "number of inhabitants"
  ) +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.x = element_blank())

# Dots
dot <- df %>% ggplot(aes(x = county, y = population)) + 
  geom_point(aes(fill = county), shape = 21, size = 4) + 
  scale_fill_OkabeIto2(darken = -.3, guide = "none") +
  coord_flip() +
  theme_bw() +
  scale_y_continuous(
    limits = c(0, 1230000),
    expand = expansion(mult = c(0, 0.05)),
    breaks = c(0, 4e5,  8e5, 12e5),
    labels = c("0", "400,000", "800,000",  "1,200,000"),
    name = "number of inhabitants"
  ) +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.x = element_blank())

dot

library(patchwork)

collage <- (pie | pie) / (bar | dot)

ggsave("three_plots.png", collage,  width = 24, height = 18, units = "cm", dpi = 300)
   



