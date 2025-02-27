Stock Price Analysis: AAPL, TSLA, and SPY (2023-2025)

Overview
This project analyzes the stock price movements of Apple Inc. (AAPL), Tesla Inc. (TSLA), and the S&P 500 ETF (SPY) from January 1, 2023, to February 25, 2025, using R. It retrieves adjusted closing prices from Yahoo Finance, calculates key financial metrics such as daily returns, annualized volatility, and 50-day moving averages, and visualizes the results to provide insights into stock performance and trends over this period.

Methodology
Data Retrieval: The quantmod package is used to fetch adjusted closing prices directly from Yahoo Finance for the specified stocks (AAPL, TSLA, SPY) and date range (January 1, 2023, to February 25, 2025).

Calculations:
Daily Returns: Computed as the percentage change in stock price from the previous day: (price_today - price_yesterday) / price_yesterday.
Annualized Volatility: Calculated by taking the standard deviation of daily returns and multiplying by the square root of 252 (the typical number of trading days in a year), representing annualized risk.
50-Day Moving Average: Derived using rollapply from the zoo package (loaded with quantmod), averaging the closing prices over the past 50 trading days to smooth trends.
Visualization: The ggplot2 package (included in tidyverse) generates two line plots: one for stock prices and another for 50-day moving averages, styled with a minimal theme on a black background with a grid.
Outputs
Data File:
stock_data.csv: A CSV file containing the adjusted closing prices for AAPL, TSLA, and SPY over the specified period.

Visualizations:
prices.png: A line graph showing the adjusted closing prices over time:
AAPL (Green Line): Starts around $123 in January 2023, grows steadily with fluctuations, reaching approximately $247 by February 2025.
TSLA (Blue Line): Begins near $108, exhibits high volatility with peaks (e.g., $479 in December 2024) and troughs, ending around $330 by February 2025.
SPY (Red Line): Starts at $370, follows a stable upward trend, reaching about $597 by February 2025, with less volatility than TSLA.
moving_avg.png: A line graph displaying the 50-day moving averages for each stock, highlighting smoothed trends.
Console Output: Prints the annualized volatility for each stock and the most recent 50-day moving averages for quick reference.
Running the Project

Prerequisites:
Install R on your system.
Install the required R packages by running the following command in an R console:
install.packages(c("quantmod", "tidyverse"))
Execution:
Save the project script (provided in the <DOCUMENT> section of the query) as, e.g., stock_analysis.R.
Open RStudio or any R environment, set your working directory to where the script is saved (optional: use setwd()), and run the script with:
source("stock_analysis.R")
Customization:
Change Stocks: Modify the stocks vector in the script (e.g., stocks <- c("GOOG", "AMZN")) to analyze different stocks.
Adjust Date Range: Update the from and to parameters in getSymbols (e.g., from = "2020-01-01", to = "2022-12-31") for a different period.
Modify Moving Average Window: Alter the width parameter in rollapply (e.g., width = 20) for a different moving average period.


Example Usage
Here’s a snippet of the script to get you started:
# Load libraries 
library(quantmod) 
library(tidyverse) 

# Define stocks and fetch data 
stocks <- c("AAPL", "TSLA", "SPY") 
getSymbols(stocks, from = "2023-01-01", to = "2025-02-25") 

# Extract and save adjusted close prices 
prices <- do.call(merge, lapply(stocks, function(x) Ad(get(x)))) 
colnames(prices) <- stocks 
write.csv(as.data.frame(prices), "stock_data.csv")

# Plot prices 
prices_df <- as.data.frame(prices) %>% 
	mutate(Date = index(prices)) %>% 
	pivot_longer(-Date, names_to = "Stock", values_to = "Price") 
ggplot(prices_df, aes(x = Date, y = Price, color = Stock)) + 
	geom_line() + 
	labs(title = "Stock Prices: Jan 2023 - Feb 2025") + 
	theme_minimal() 
ggsave("prices.png")

Notes
Data Source: Prices are sourced from Yahoo Finance via quantmod. Data accuracy and availability depend on Yahoo Finance’s service.
Assumptions: The project assumes 252 trading days per year for volatility calculations, a standard approximation in financial analysis.
 Future Dates: Since the date range extends to February 2025, data beyond the current date (e.g., October 2023) is hypothetical or projected in your provided sample.
 Resources: For more on financial metrics, visit Investopedia.
This project serves as a practical tool for financial analysts, students, or enthusiasts interested in exploring stock price trends and volatility using R.
