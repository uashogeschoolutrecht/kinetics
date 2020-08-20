#' Prints lines graphs
#' @export

print_lines <- function(analyte){

  data_plot <- data_split[[analyte]]
  plot <- draw_lines(DF = data_plot,
                     palette_graph = palette)
  return(plot)
}


