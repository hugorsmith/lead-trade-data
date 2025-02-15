# There are two parts of this code. The first assumes you have the original BACI data all in one sub-folder, and then imports that and pulls all the relevant lead data.
# The second part does some light processing to make the data easier to read within the CSV. 

# Libraries
library(data.table)
library(dplyr)
library(readr)

# Filter and compile lead-related BACI data

# Define the HS codes we want
hs_codes <- c("850710", "850720", "780200", "854810", 
              "260700", "780110", "780191", "780199")

# Get list of BACI files with correct folder path
baci_files <- list.files(path = "BACI_HS12_V202501", 
                         pattern = "^BACI.*\\.csv$",
                         full.names = TRUE)

# Read and combine all files, filtering only for desired HS codes
baci_combined <- rbindlist(
  lapply(baci_files, function(file) {
    fread(file)[k %in% hs_codes]
  }),
  use.names = TRUE
)

# Save the result
fwrite(baci_combined, "BACI_lead_trade_2012_2023.csv")
print("BACI data has been filtered and merged")

# Modify the combined data to make it easier to deal with
# Read the CSV files
baci_data <- read_csv("BACI_lead_trade_2012_2023.csv")
country_codes <- read.csv("BACI_HS12_V202501/country_codes_V202501.csv")
product_codes <- read.csv("BACI_HS12_V202501/product_codes_HS12_V202501.csv")

# Step 1: Rename the basic fields
baci_processed <- baci_data %>%
  rename(
    year = t,
    exporter = i,
    importer = j,
    product = k,
    value = v,
    quantity = q
  )

# Step 2: Add country names and ISO3 codes
baci_processed <- baci_processed %>%
  # Join with country_codes for exporter information
  left_join(
    country_codes %>% 
      select(
        country_code,
        exporter_name = country_name,
        exporter_iso3 = country_iso3
      ),
    by = c("exporter" = "country_code")
  ) %>%
  # Join with country_codes for importer information
  left_join(
    country_codes %>% 
      select(
        country_code,
        importer_name = country_name,
        importer_iso3 = country_iso3
      ),
    by = c("importer" = "country_code")
  )

# Step 3: Add product descriptions
baci_processed <- baci_processed %>%
  left_join(
    product_codes %>%
      select(
        code,
        product_description = description
      ),
    by = c("product" = "code")
  )

# Write the processed data to a new CSV file
write_csv(baci_processed, "BACI_lead_trade_2012_2023_modified_vHS.csv")

# Print a summary to verify the processing
summary(baci_processed)

