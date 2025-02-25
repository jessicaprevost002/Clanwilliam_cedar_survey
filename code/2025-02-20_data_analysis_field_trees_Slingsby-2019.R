### Cleaning up and initial analysis of data on field trees from Slingsby & Slingsy (2019)
### Dataset: https://doi.org/10.6084/m9.figshare.7670435.v1 
### "fieldtrees.gpkg" is a GeoPackage format file containing unprojected tree localities that were mapped in the field and includes tree health and size data. 
### Dataset supplement to: Slingsby, J.A. & Slingsby, P.W.O. 2019. Monitoring the critically endangered Clanwilliam cedar with freely available Google Earth imagery. PeerJ. https://doi.org/10.7717/peerj.7005  
### Dataset license: CC BY 4.0

# load libraries
library(tidyverse)
library(sf)
library(lubridate)
library(ggspatial)

# import spatial data
raw_fieldtree <- st_read("data/data_raw_field_trees_Slingsby-2019.gpkg")

### check spatial data
class(raw_fieldtree)
summary(raw_fieldtree)
head(raw_fieldtree)

# check crs
st_crs(raw_fieldtree)

### tidy data

# see which entries don't have a value for time 
raw_fieldtree %>%
  filter(is.na(time)) 

# fix entries where the time is in cmt variable instead of time variable
fieldtree <- raw_fieldtree %>%
  mutate(time = ifelse(!is.na(time), time, format(dmy_hms(cmt), "%Y/%m/%d %H:%M:%S+00"))) %>% 
  select(-cmt)
  # ignore failed to parse error as this the one entry with a comment which isn't a date

head(fieldtree)

# long form data
long_fieldtree <- fieldtree %>%
  pivot_longer(cols = c("site", "Size", "State"),
               names_to = "variable", values_to = "value")
head(long_fieldtree)

### plot data
# plot using ggspatial 

# create df with x and y coords which is required for geom_spatial_point
df_fieldtree <- cbind(as.data.frame(fieldtree), st_coordinates(fieldtree))

# plot trees by site with different colours for different states of alive/dead
ggplot(df_fieldtree) +
  geom_spatial_point(crs = 4326, aes(x = X, y = Y, color = State)) +
  facet_wrap(~site, scales = "free", labeller = labeller(site = c("jsa12" = "Site 1", "jsa13" = "Site 2", "jsgm" = "Site 3"))) +
  theme_minimal() +
  scale_color_manual(labels = c(" Alive (Survey)" = "Alive", " Dead (Survey)" = "Dead"), values = c(" Alive (Survey)" = "green", " Dead (Survey)" = "red")) +
  labs(x = "Longitude", y = "Latitude") +
  facet_wrap(~site, scales = "free") +
  theme_minimal()

# change crs to UTM to see ground distance in meters
utm_fieldtree <- st_transform(fieldtree, 32734)

# create df with x and y coords which is required for geom_spatial_point
df_fieldtree <- cbind(as.data.frame(utm_fieldtree), st_coordinates(utm_fieldtree))

# plot trees by site with different colours for different states of alive/dead using UTM crs
site_plot_utm <- ggplot(df_fieldtree) +
  geom_spatial_point(crs = 32734, aes(x = X, y = Y, color = State)) +
  theme_minimal() +
  facet_wrap(~site, scales = "free")

site_plot
