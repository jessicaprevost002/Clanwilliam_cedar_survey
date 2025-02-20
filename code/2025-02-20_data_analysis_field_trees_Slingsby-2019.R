### Cleaning up and initial analysis of data on field trees from Slingsby & Slingsy (2019)
### Dataset: https://doi.org/10.6084/m9.figshare.7670435.v1 
### "fieldtrees.gpkg" is a GeoPackage format file containing unprojected tree localities that were mapped in the field and includes tree health and size data. 
### Dataset supplement to: Slingsby, J.A. & Slingsby, P.W.O. 2019. Monitoring the critically endangered Clanwilliam cedar with freely available Google Earth imagery. PeerJ. https://doi.org/10.7717/peerj.7005  
### Dataset license: CC BY 4.0

# load libraries
library(tidyverse)
library(sf)

# import spatial data
raw_fieldtree <- st_read("data/data_raw_field_trees_Slingsby-2019.gpkg")

### check spatial data
class(raw_fieldtree)
summary(raw_fieldtree)
head(raw_fieldtree)
view(raw_fieldtree)

# check crs
st_crs(raw_fieldtree)

### tidy data

# fix entries where the time is in cmt variable instead of time variable
# see which entries don't have a value for time 
raw_fieldtree %>%
  filter(is.na(time))


# long form data
long_fieldtree <- raw_fieldtree %>%
  pivot_longer(cols = c("site", "Size", "State"),
               names_to = "variable", values_to = "value")
head(long_fieldtree)





