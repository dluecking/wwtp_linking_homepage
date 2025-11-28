# Author: dlu @ veelab
# Version: 2025-11-28


files <- list.files("cluster_plots", pattern = "\\.html$", full.names = FALSE)

options_html <- paste0(
  '<option value="', files, '">', files, '</option>',
  collapse = "\n"
)

writeLines(options_html, "options.html")
