#install packages for quant data and integration 
#Data Source: quantmod pulls from Yahoo Finance automatically—no manual downloads needed.
#quantmod for data, tidyverse for wrangling, and ggplot2 for plots (included in tidyverse).

install.packages(c("quantmod", "tidyverse"))

library(quantmod)

stocks <- c("AAPL", "TSLA", "SPY")
getSymbols(stocks, from = "2023-01-01", to = "2025-02-25")

# Extract adjusted close prices
prices <- do.call(merge, lapply(stocks, function(x) Ad(get(x))))
colnames(prices) <- stocks

# Save to CSV
write.csv(as.data.frame(prices), "stock_data.csv")

# Daily returns
returns <- na.omit(prices / lag(prices, 1) - 1)

# Annualized volatility (252 trading days)
volatility <- apply(returns, 2, sd) * sqrt(252)

# 50-day moving average
moving_avg <- rollapply(prices, width = 50, FUN = mean, fill = NA, align = "right")

# Peek at results
print("Volatility:")
print(volatility)
print("Recent 50-day MA:")
tail(moving_avg)

library(tidyverse)

# Convert prices to a tidy format
prices_df <- as.data.frame(prices) %>% 
  mutate(Date = index(prices)) %>% 
  pivot_longer(-Date, names_to = "Stock", values_to = "Price")

# Plot prices
ggplot(prices_df, aes(x = Date, y = Price, color = Stock)) +
  geom_line() +
  labs(title = "Stock Prices: Jan 2023 - Feb 2025") +
  theme_minimal()
ggsave("prices.png")

# Moving averages
ma_df <- as.data.frame(moving_avg) %>% 
  mutate(Date = index(moving_avg)) %>% 
  pivot_longer(-Date, names_to = "Stock", values_to = "MA")

ggplot(ma_df, aes(x = Date, y = MA, color = Stock)) +
  geom_line() +
  labs(title = "50-Day Moving Averages") +
  theme_minimal()
ggsave("moving_avg.png")
