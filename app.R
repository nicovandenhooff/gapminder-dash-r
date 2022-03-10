library(dash)
library(plotly)
library(ggplot2)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)

# dashboard
app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

# dataset
gapminder <- readr::read_csv(here::here('data', 'gapminder.csv')) %>% 
  mutate(log_income = log(income)) %>% 
  tidyr::drop_na()

app$layout(
  dbcContainer(
    list(
      htmlH1("Gapminder Dashboard"),
      dccGraph(id="bubblechart"),
      dccSlider(
        id = "yr",
        min = 1970,
        max = 2010,
        step = 5,
        marks = list(
          "1970" = "1970",
          "1975" = "1970",
          "1980" = "1980",
          "1985" = "1985",
          "1990" = "1990",
          "1995" = "1995",
          "2000" = "2000",
          "2005" = "2005",
          "2010" = "2010"
        ),
        value = 2010
      )
    )
  )
)

app$callback(
  output("bubblechart", "figure"),
  list(input("yr", "value")),
  function(yr) {
    data <- gapminder %>% 
      dplyr::filter(year == yr)
    
    p <- data %>% 
      ggplot(
        aes(
          x = log_income,
          y = life_expectancy,
          color = region,
          size = population
        )
      ) +
        geom_point() +
        ggthemes::scale_color_tableau() +
        labs(
          x = "Income (Log Scale)",
          y = "Life Expectancy",
          title = "Income vs. Expectancy",
          color = "Region",
          size = "Population"
        )
    
    ggplotly(p)
  }
)

app$run_server(host = '0.0.0.0')

# app$run_server(debug = T)