# Seeds Data

This folder contains the static data for the database needed for the site to function. It does not include any dynamic data.

# Ranks and Entitlements

The weight entitlements by rank name are found in `entitlements.yml`. This information comes from the DTR, Part IV, Appendix K-1.

# 400NG Baseline Rates

Each year's domestic Baseline Rates file from SDDC can be found on their [Personal Property->Household Goods page](https://www.sddc.army.mil/pp/Pages/houseGoods.aspx), under the "Special Requirements and Rates Team -> Domestic" tab. Rates for each year (to take effect on May 15 of that year) are published in December of the previous year.

As the maximum entitlement is 20500 lbs (O-10 w/ progear), there is currently no logic for calculating costs at 24000 lbs and beyond, and the "each addl CWT" columns from the original spreadsheet are all ignored.

## Preparing a new 400NG Baseline Rates for inclusion

SDDC publishes the 400NG tables in an Excel file, but it's not very clean. Cleaning it up reduces the time it takes to import from roughly 30 seconds to under a second, with dramatically lower RAM usage as well.

To clean it up:

1. Open the file in Excel. Ignore links to other documents.
1. In each sheet, select the first empty column to the right of all content.
1. Select all columns from there to the end. On Macs, this is done by pressing "Shift + Command + (right arrow)."
1. Edit->Delete
1. Select the first empty row below all content.
1. Select all rows from there to the end. On Macs, this is done by pressing "Shift + Command + (down arrow)."
1. Edit->Delete
1. Once you have removed the extraneous garbage from each sheet, save the file and drop it in `db/seeds`. It should have dropped in size from over 6 MiB to less than than 200 KiB.

Now you can add the new year's baseline rates to `seeds.rb`.

# Discounts from top TSP (by BVS) by channel

The list of discounts by channel, corresponding to the top TSP's discount filed during the previous rate-filing cycle, is used to generate PPM estimates. These discounts are trade secrets, so this data needs to be encrypted so that it is not stored in the clear on GitHub.

## Encrypting discounts file for a new TDL

Each discount list only applies to a single TDL (tonnage distribution list), so in practice, only for a few months. As new lists are generated, they need to be encrypted, put in the `db/seeds/` folder, and loaded in `seeds.rb`.

The encryption command is:

`openssl enc -aes-256-cbc -iv $SEEDS_ENC_IV -K $SEEDS_ENC_KEY -in (input) -out (output.enc)`

# free_zipcode_data

To lookup the city / state and geographic centroid coordinates of ZIP codes, we rely on data collected and published by the [`free_zipcode_data` project on GitHub](https://github.com/midwire/free_zipcode_data/). If you wish to update any of this data, simply go to [`free_zipcode_data`'s project page](https://github.com/midwire/free_zipcode_data/) and replace our copy of their CSV data with the latest version.
