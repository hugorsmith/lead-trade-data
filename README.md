# Lead Trade Data

This repo contains data on the global trade of lead and lead batteries from 2012 through 2023. BACI data is up to date through 2023 (the latest release); Comtrade data only through 2022 due to some annoying features of the free Comtrade API.

It has two folders: 1. *comtrade*: raw trade data from UN's [Comtrade](https://comtradeplus.un.org/) database. 2. *baci*: data from CEPII's [BACI](https://www.cepii.fr/CEPII/en/bdd_modele/bdd_modele_item.asp?id=37) database that provides a reconciled (and likely more accurate) version of the Comtrade data. The data is from their HS12 release version 202501.

Within BACI, I created a file called *BACI_lead_trade_2012_2023_modified_vHS.csv*. This made the fields names easier to interpret, and merged in the country names and product descriptions. This is probably the single easiest file to use for analysis.

The data is filtered down to the following Harmonized System codes:

| Type | Code | Description |
|----|----|----|
| New Batteries | 850710 | Electric accumulators; lead-acid, of a kind used for starting piston engines, including separators, whether or not rectangular (including square) |
|  | 850720 | Electric accumulators; lead-acid, (other than for starting piston engines), including separators, whether or not rectangular (including square) |
| Scrap | 780200 | Lead; waste and scrap |
|  | 854810 | Waste and scrap of primary cells, primary batteries and electric accumulators; spent primary cells, spent primary batteries and spent electric accumulators |
| New Lead | 260700 | Lead ores and concentrates |
|  | 780110 | Lead; unwrought, refined |
|  | 780191 | Lead; unwrought, unrefined, containing by weight antimony as the principal other element |
|  | 780199<br> | Lead; unwrought, unrefined, not containing by weight antimony as the principal other element |

It also includes the R files I used to merge and modify the data. If you want to get more recent Comtrade data, you can tweak the years in the Comtrade code.
