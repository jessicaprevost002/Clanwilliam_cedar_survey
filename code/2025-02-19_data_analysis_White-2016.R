### Cleaning up and initial analysis of data on repeat photography mortality study by White et al. 2016
### Dataset: White, J.D.M., Jack, S., Puttick, J., Bonora, D., Visser, V., February, E. 2016. Mortality and climatic/environmental correlates of Widdringtonia cedargensis trees in the Cederberg, South Africa [dataset]. PANGAEA, https://doi.org/10.1594/PANGAEA.866937
### Dataset supplement to: White, J.D.M., Jack, S., Hoffman, M.T., Puttick, J., Bonora, D., Visser, V., February, E. 2016. Collapse of an iconic conifer: long-term changes in the demography of Widdringtonia cedarbergensis using repeat photography. BMC Ecology, 16(1), 11 https://doi.org/10.1186/s12898-016-0108-6
### Dataset license: CC BY 3.0

# load libraries
library(tidyverse)

# import data
raw_cedar <- read_csv("data/data_raw_repeat_photography_White-2016.csv")

## important metadata
# Number: tree number
# Mortality: 1 = a mortality event; 0 = a tree remains alive
# Fire frequency: number of fires recorded for each specific GPS location (i.e. tree) over the recorded period between 1944-2012

# check data
view(raw_cedar)
summary(raw_cedar)

# clean data

