#' Prints panel lines
#' @export

print_lines_panel <- function(analyte, ...){

  ymax_data <- max(data_split[[analyte]]$mean_conc)
  sem_max <- max(data_split[[analyte]]$sd)
  ymax <- 1.05*(ymax_data)

  ymin_data <- min(data_split[[analyte]]$mean_conc)
  ymin <- ymin_data - (0.02*ymin_data)

  data_plot <- data_split[[analyte]]


  plot <- kinetics::draw_lines_panel(DF = data_plot,
                           palette_graph = palette,
                           ymax = ymax,
                           ymin = ymin, x_pos = ...)



  return(plot)
}
