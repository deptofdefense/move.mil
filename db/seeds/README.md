# Seeds

# ZIP3 to ZIP3 distances from DTOD

## Generating the input

`zip3_dtod.py` is a python script that generates a two-column, space-delimited list of ZIP3 pairs, useful for submitting batches of distance requests to the [Defense Table of Official Distances a.k.a. DTOD](https://dtod.sddc.army.mil).

If a new ZIP3 prefix enters or leaves service with the USPS, just alter the zip3 array in zip3_dtod.py accordingly, and regenerate the output by running

`$ ./zip3_dtod.py | split -l 174762 -

This will make several files with filenames starting with `xa`. Why pipe the output to split? As of this writing, DTOD's batch distance processing tool limits uploads to 2 MiB. 174762 lines * 12 bytes per line = 2097144 bytes, just under 2 MiB.

## Uploading the input

Once you have generated the input files, go to the [Calculate Distances -> Batch Processing page on DTOD](https://dtod.sddc.army.mil/Content/CalculateDistances/Batch.aspx) and complete the form.

 * **File Request Contact Information:** I put in my mail.mil e-mail address; I do not know if the tool believes a dds.mil address is a "valid government e-mail address."
 * **Data Input Type:** ZipCode
 * **Route Options:** 1. North America, 2. DITY, 3. Miles

Upload each input file, one per iteration of the form. You do not need to wait for the previous batch to finish before submitting the next one. However, it does take DTOD a while to churn through hundreds of thousands of ZIP3 pairs, so expect to wait multiple hours.

## Collecting the output

Once DTOD has sent you all of the results, concatenate them together and write them to `zip3_dtod_output.csv`. Join the files in the same order that they were generated. The database doesn't care, but it will make the git diff shorter.

# Data from 400NG Baseline Rates

Each year's 400NG file from SDDC can be found on their [Personal Property->Household Goods page](https://www.sddc.army.mil/pp/Pages/houseGoods.aspx), under the "Special Requirements and Rates Team -> Domestic" tab. The file contains several tabs that need to be unpacked and processed into separate CSV files so that the data can be imported into the database.

As the maximum entitlement is 20500 lbs (O-10 w/ progear), there is currently no logic for calculating costs at 24000 lbs and beyond, and the "each addl CWT" columns from the original spreadsheet are all ignored.

## Linehaul.xlsm

SDDC publishes the 400NG tables in an Excel file, so to process them into CSVs that we can digest, you need to run some Visual Basic for Applications (VBA) code.
