#' Create a summary line graph from a single analyte; suitable for multipanelled plots
#'
#' A function to create a summary line graph from a
#' dataset based on a single analyte.
#'
#' @param DF A data.frame containing data for a single analyte
#' @param palette_graph A palette with 5 colours
#'
#' @return a ggplot2 object and the function writes to
#' disk in the directory defined by the function
#' saveInImageDirectory
#'
#' @export


draw_lines_panel <- function(DF,
                             x_pos,
                             palette_graph,
                             ymax = max(DF$mean_conc * 1.5),
                             ymin = min(DF$mean_conc * 0.8)) {
  nameLine <- DF$analyte[1] %>%
    tolower()
  nameFile <- c(nameLine)
  ################################
  # get analyte metadata
  ################################


  y_axis_label <- kinetics::analyte_annotations %>%
    dplyr::filter(tolower(analyte_short) == nameLine) %>%
    dplyr::select(units) %>%
    as.character()
  ###########################
  # long name for analyte
  ###########################
  long_name <- kinetics::analyte_annotations %>%
    dplyr::filter(tolower(analyte_short) == nameLine) %>%
    dplyr::select(analyte_long_name) %>%
    as.character()

  firstup <- function(x) {
    substr(x, 1, 1) <- toupper(substr(x, 1, 1))
    x
  }

  plot_title <- firstup(long_name)
  y_lim_max <- ymax
  y_lim_min <- ymin

  plot <- ggplot2::ggplot(data = DF, aes(x = time,
                                         y = mean_conc,
                                         colour = protocol)) +

    ggplot2::geom_point(
      aes(shape = protocol),
      size = 1.6,
      position = position_dodge(width = 0.2),
      show.legend = FALSE
    ) +

    ggplot2::geom_line(
      aes(group = protocol),
      size = 1.2,
      alpha = 8 / 9,
      position = position_dodge(width = 0.2)
    ) +

    ggplot2::scale_colour_manual(
      labels = c("Rest",
                 "70% Wmax",
                 "70% Wmax/DH",
                 "50% Wmax",
                 "55%/85% Wmax"),
      values = palette_graph
    )   +
    ggplot2::geom_vline(xintercept = x_pos[1], linetype = "dashed") +
    ggplot2::geom_vline(xintercept = x_pos[2], linetype = "dashed") +

    geom_label(aes(x = x_pos[1],
                   y = y_lim_min,
                   label = "T0"), colour = "black") +

    geom_label(aes(x = x_pos[2],
                   y = y_lim_min,
                   label = "T1"), colour = "black") +
    ggplot2::scale_shape_manual(values = c(5, 6, 15:17)) +
    ggplot2::scale_y_continuous(limits = c(ymin, ymax)) +
    # ggtitle(nameLine)  +
    ggplot2::xlab("Time (hours)") +
    ggplot2::ylab(paste("Concentration", paste0("(",
                                                y_axis_label,
                                                ")"))) +
    ggplot2::ggtitle(plot_title) +
    kinetics::theme_panel() +
    theme(legend.key.size = unit(1, "cm"),
          legend.key.width = unit(1, "cm"))




  png <- paste(nameFile, "panel_line.png", sep = "")
  #  eps <- paste(nameFile,"line.eps", sep = "")
  svg <- paste(nameFile, "panel_line.svg", sep = "")

  jpeg <- paste(nameFile, "panel_line.jpeg", sep = "")


  ## saving the file to the imageDir
  kinetics::save_in_image_directory(svg)
  # saveInImageDirectory(eps)
  kinetics::save_in_image_directory(png)

  kinetics::save_in_image_directory(jpeg)

  return(plot)

}

