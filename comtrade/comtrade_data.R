# This code pulls the relevant Comtrade data for lead. Because of the limits on the free Comtrade API, as well as the file size, it's been broken down into groups.

library("devtools")
library("tidyverse")

comtradr::set_primary_comtrade_key("") # Insert your Comtrade API key here

# Define relevant Comtrade codes
new_batt_codes <- c("850710", "850720")
scrap_codes <- c("780200", "854810")
new_lead_codes <- c("260700", "780110", "780191", "780199")

# Pull trade data

# Imports 
new_battery_data_imports <- ct_get_data(
  reporter =  "all_countries",
  flow_direction = "import",
  partner = "all_countries",
  start_date = 2012,
  end_date = 2022,
  commodity_code = new_batt_codes
)

scrap_data_imports <- ct_get_data(
  reporter =  "all_countries",
  flow_direction = "import",
  partner = "all_countries",
  start_date = 2012,
  end_date = 2022,
  commodity_code = scrap_codes
)

new_lead_data_imports <- ct_get_data(
  reporter =  "all_countries",
  flow_direction = "import",
  partner = "all_countries",
  start_date = 2012,
  end_date = 2022,
  commodity_code = new_lead_codes
)

# Exports
new_battery_data_exports <- ct_get_data(
  reporter =  "all_countries",
  flow_direction = "export",
  partner = "all_countries",
  start_date = 2012,
  end_date = 2022,
  commodity_code = new_batt_codes
)

scrap_data_export <- ct_get_data(
  reporter =  "all_countries",
  flow_direction = "export",
  partner = "all_countries",
  start_date = 2012,
  end_date = 2022,
  commodity_code = scrap_codes
)

new_lead_data_export <- ct_get_data(
  reporter =  "all_countries",
  flow_direction = "export",
  partner = "all_countries",
  start_date = 2012,
  end_date = 2022,
  commodity_code = new_lead_codes
)

# Imports - add flow code
new_battery_data_imports$flow_code <- "I"
scrap_data_imports$flow_code <- "I"
new_lead_data_imports$flow_code <- "I"

# Exports - add flow code
new_battery_data_exports$flow_code <- "X"
scrap_data_export$flow_code <- "X"
new_lead_data_export$flow_code <- "X"

# Now merge by type
new_battery_data <- rbind(new_battery_data_imports, new_battery_data_exports)
scrap_data <- rbind(scrap_data_imports, scrap_data_export)
new_lead_data <- rbind(new_lead_data_imports, new_lead_data_export)

# Create central file
combined_lead_data <- rbind(new_battery_data, scrap_data, new_lead_data)

# Write csvs
write.csv(new_battery_data, "comtrade_new_battery_data_2012_2022.csv",row.names = FALSE)

write.csv(scrap_data, "comtrade_scrap_data_2012_2022.csv",row.names = FALSE)

write.csv(new_lead_data, "comtrade_new_lead_data_2012_2022.csv",row.names = FALSE)

write.csv(combined_lead_trade_data, "comtrade_combined_lead_data_2012_2022.csv",row.names = FALSE)




