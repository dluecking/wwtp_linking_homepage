# Author: dlu @ veelab
# Version: 2025-11-28


files <- list.files("cluster_plots", pattern = "\\.html$", full.names = FALSE)

gv_df <- fread("data/GV Genome Overview - Final GVs overview.csv")
vph_df <- fread("data/vph_df.csv")
plv_df <- fread("data/plv_df.csv")

options_df <- data.table(
  path = files,
  name = ""
)

# fill in correct name
for(i in 1:nrow(options_df)){
  current_path <- options_df$path[i]
  
  if(str_detect(options_df$path[i], "vph")){
    # its a vph so:
    current_path <- str_remove(current_path, "_vph_interactive.html")
    options_df$name[i] <- vph_df$public_ID[vph_df$contig_ID == current_path]
    
    next
  }
  if(str_detect(options_df$path[i], "plv")){
    # its a plv
    current_path <- str_remove(current_path, "_interactive.html")
    options_df$name[i] <- plv_df$public_ID[plv_df$contig == current_path]
    
    next
  }
  else{
    # its a ncv
    current_path <- str_remove(current_path, "_interactive.html")
    options_df$name[i] <- gv_df$public_ID[gv_df$shortname == current_path]
  }
}


options_html <- paste0(
  '<option value="', options_df$path, '">', options_df$name, '</option>',
  collapse = "\n"
)

writeLines(options_html, "options.html")
