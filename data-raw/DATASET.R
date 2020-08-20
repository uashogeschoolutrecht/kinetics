## code to prepare `DATASET` dataset goes here

######################################################################
## RPE (Borg scale score data)
######################################################################

rpe_scores <- readxl::read_xlsx(
  here::here(
    "data-raw",
    "D410",
    "rpe_scores_met T65_kinetics.xlsx")) %>%
  mutate(subject = factor(subject)) %>%
  mutate(protocol = factor(protocol)) %>%
  mutate(time = factor(time)) %>%
  mutate(rpe = as.numeric(rpe))

usethis::use_data(rpe_scores, overwrite = TRUE)

####################################################################
## Heatmap of P and F-values
### Data
#Here we use the statistical data supplied by Eric Schoen:
# - The F-values of the multilevel comparisons
# - The P-values (multiplied by 1000x)
### F Values - Data
####################################################################

path_to_file_protocol_f <- here::here(
  "data-raw",
  "D017",
  "F values protocol contrasts_cleaned.xlsx")


f_values_protocol <- readxl::read_xlsx(path = path_to_file_protocol_f,
                                       sheet = "Sheet1",
                                       na = c("NA")) %>%
  as_tibble()

# path_to_file_time <- file.path(root,
#                           "data-raw",
#                           "D017",
#                           "F values time contrasts_cleaned.xlsx")
#
# f_values_time <- xlsx::read.xlsx(file = path_to_file_time, sheetName = "Sheet1") %>%
#   as_tibble()

f_values_long_protocol <- f_values_protocol %>%
  rename(analyte = amlab,
         P1_P2 = `1`,
         P1_P3 = `2`,
         P1_P4 = `3`,
         P1_P5 = `4`,
         P2_P3 = `5`,
         P2_P4 = `6`,
         P2_P5 = `7`) %>%

  gather(P1_P2:P2_P5, key = "contrast", value = "value") %>%
  dplyr::filter(analyte != "lymphocytes") %>%
  dplyr::mutate(analyte = forcats::as_factor(new_name)) %>%
  dplyr::select(-new_name) %>%
  dplyr::arrange(analyte) %>%
  as_tibble() %>%
  print()

usethis::use_data(f_values_long_protocol)

#############################################################################
# P-values data
#############################################################################

path_to_file_protocol_p <- here::here(
  "data-raw",
  "D017",
  "heatmapPvalues_X1000_cleaned_SKa.xlsx")

p_values_protocol <- readxl::read_xlsx(path = path_to_file_protocol_p,
                                       sheet = "Sheet1",
                                       na = c("NA")) %>%
  as_tibble()

p_values_long_protocol <- p_values_protocol %>%
  rename(analyte = amlab,
         P1_P2 = P2,
         P1_P3 = P3,
         P1_P4 = P4,
         P1_P5 = P5,
         P2_P3 = `P2 vs P3`,
         P2_P4 = `P2 vs P4`,
         P2_P5 = `P2 vs P5`) %>%
  mutate(analyte = tolower(analyte)) %>%

  tidyr::gather(P1_P2:P2_P5, key = "contrast", value = "value") %>%
  #  filter(analyte != "lymphocytes") %>% # remove uncorrected lymphocytes
  mutate(analyte = forcats::as_factor(new_name)) %>%
  dplyr::select(-new_name) %>%
  arrange(analyte) %>%
  dplyr::mutate(statistic = "p_value")

usethis::use_data(p_values_long_protocol)

#############################################################################
# Analyte annotations
#############################################################################
analyte_annotations <- readxl::read_excel(
  path =
    here::here(
      "data-raw",
      "D016",
      "Copy of analytes_complete_ref_unit_SKa.xlsx"
    ),
  sheet = 1
)

usethis::use_data(analyte_annotations)

