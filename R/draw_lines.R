#' Create a summary line graph from a single analyte
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


draw_lines <- function(DF,
                       palette_graph)
  # ymax,
  # ymin
{

  nameLine <- DF$analyte[1] %>%
    tolower()


  nameFile <- c(nameLine)

  ################################
  # get analyte metadata
  ################################
  analyte_annotations <- readxl::read_excel(path =
                                              here::here(
                                                "data-raw",
                                                "D016",
                                                "Copy of analytes_complete_ref_unit_SKa.xlsx"),
                                            sheet = 1)

  y_axis_label <- analyte_annotations %>%
    dplyr::filter(tolower(analyte_short) == nameLine) %>%
    dplyr::select(units) %>%
    as.character()

  ###########################
  # long name for analyte
  ###########################
  long_name <- analyte_annotations %>%
    dplyr::filter(tolower(analyte_short) == nameLine) %>%
    dplyr::select(analyte_long_name) %>%
    as.character()

  firstup <- function(x) {
    substr(x, 1, 1) <- toupper(substr(x, 1, 1))
    x
  }

  plot_title <- firstup(long_name)

  plot <- ggplot2::ggplot(data = DF,
                          aes(x = time,
                              y = mean_conc,
                              colour = protocol)) +
    ggplot2::geom_point(aes(shape = protocol),
                        size = 3,
                        position = position_dodge(width = 0.2),
                        show.legend = FALSE) +
    ggplot2::geom_line(aes(group = protocol),
                       size = 1.6,
                       position = position_dodge(width = 0.2)) +
    ggplot2::scale_colour_manual(labels = c("Rest",
                                            "70% Wmax",
                                            "70% Wmax/DH",
                                            "50% Wmax",
                                            "55%/85% Wmax"),
                                 values = palette_graph)   +
    ggplot2::geom_vline(xintercept = 1, linetype = "dashed") +
    ggplot2::geom_vline(xintercept = 3, linetype = "dashed") +

    geom_label(aes(x = 1, y = 0,
                   label = "T0"), colour = "black") +

    geom_label(aes(x = 3, y = 0,
                   label = "T1"), colour = "black") +
    ggplot2::scale_shape_manual(values=c(5,6, 15:17)) +
    kinetics::theme_individual() +
    ggplot2::xlab("Time (hours)") +
    ggplot2::ylab(
      paste("Concentration",
            paste0("(", y_axis_label, ")"))) +
    ggplot2::ggtitle(plot_title)

  ##assigning a name to the file
  png <- paste(nameFile,"line.png", sep = "")
  #  eps <- paste(nameFile,"line.eps", sep = "")
  svg <- paste(nameFile,"line.svg", sep = "")

  jpeg <- paste(nameFile,"line.jpeg", sep = "")

  ## saving the file to the imageDir
  #save_in_image_directory <- function(filename,
  #                                    f.height = 9,
  #                                    f.width = 14, ...){
  #  imageFile <- file.path(image_directory, filename)
  #  ggplot2::ggsave(imageFile,
  #                  dpi = 900,
  #                  width = f.width,
  #                  height = f.height, ...)
  #}

  kinetics::save_in_image_directory(svg)
  # saveInImageDirectory(eps)
  kinetics::save_in_image_directory(png)
  kinetics::save_in_image_directory(jpeg)

  return(plot)


}
