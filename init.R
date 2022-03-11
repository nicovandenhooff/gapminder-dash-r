# R script to run author supplied code, typically used to install additional R packages
# contains placeholders which are inserted by the compile script
# NOTE: this script is executed in the chroot context; check paths!

r <- getOption('repos')
r['CRAN'] <- 'http://cloud.r-project.org'
options(repos=r)

# ======================================================================

install.packages(c('dash', 'readr', 'here', 'ggthemes', 'remotes', 'dashHtmlComponents', 'gapminder', 'ggplot2', 'plotly'))
remotes::install_github('facultyai/dash-bootstrap-components@r-release')