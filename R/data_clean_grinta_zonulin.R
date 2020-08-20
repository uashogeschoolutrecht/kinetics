#' loads a clean zonulin dataset for the GRINTA! study
#'
#'
#' @aliases zonulin
#' @export



data_clean_grinta_zonulin <- function(){

library(tidyverse)
#library(gramlyr)


####################################################
### data load zonulin data
### "./data-raw/D260/zonulin results_GRINTA.xlsx
###################################################

if(!require("rprojroot")) install.packages("rprojroot", dependencies = TRUE)
library(rprojroot)
root <- rprojroot::find_root_file(criterion = is_r_package)
root

grinta_zonulin <- readxl::read_xlsx(file.path(root,
                                       "data-raw",
                                       "D260",
                                       "zonulin results_GRINTA.xlsx"))

###################################################
## Clean data
####################################################

names(grinta_zonulin) <- tolower(names(grinta_zonulin))
names(grinta_zonulin)

names(grinta_zonulin)[2] <- "subject"
names(grinta_zonulin)[4] <- "time"
names(grinta_zonulin)[8] <- "result"

grinta_zonulin$NEW_row_id <- c(1:nrow(grinta_zonulin))

grinta_zonulin$time <-
grinta_zonulin$time %>%
  as.character() %>%
  as_factor()

grinta_zonulin$time %>% levels()

grinta_zonulin$time <- fct_recode(grinta_zonulin$time,
                           "0" = "0",
                           "0.5" = "30",
                           "1" = "60",
                           "1.5" = "90",
                           "2" = "120",
                           "3" = "180",
                           "6" = "360",
                           "24" = "24")


grinta_zonulin$time <- fct_relevel(grinta_zonulin$time,
                          c("0",
                            "0.5",
                            "1",
                            "1.5",
                            "2",
                            "3",
                            "6",
                            "24"))



levels(grinta_zonulin$time)
data_clean_grinta_zonulin <- grinta_zonulin


return(grinta_zonulin)



}
