// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © cvj0ven

//@version=4
study("forzia", overlay=true)


fast = ema(close,9)
slow = sma(close,20)
slow50 = sma(close,50)
// slow100 = sma(close,100)
plot(fast, color=color.green)
plot(slow, color=color.red)
plot(slow50, color=color.purple)
// plot(slow100, color=color.blue)


edgeLength = 9
top = sma(high, edgeLength)
bot = sma(low, edgeLength)

barTop = (close > open) ? close : open
barBot = (close > open) ? open : close
topWick = high - barTop
botWick = barBot - low
bar = barTop - barBot


// crossing 9ema while 9ema > 20ma
isBullish = close[1] <= fast[1] and close > fast and fast > slow and close > open[1] 

// price crossing 9ema
if (not isBullish and close > fast and close[1] < fast[1])
    isBullish := close > open and close > high[1] and (close > high[2] or close > close[2]) // crossing 9ema from below

// Body bar must be greater than top wick
// if (isBullish)
//     isBullish := bar > topWick
    
// 9ema crossed above 20ma and close is above prev 2 closes
if (not isBullish and fast > slow and fast[1] < slow[1])
    isBullish := close > open and close > close[1] and close > close[2]
    
// Close must be above 50ma
// if (isBullish)
//     isBullish := close > slow50

// Final bullish check, current close must be highest within 5 candle range
if (isBullish)
    isBullish := (close > high[1] and close > high[2] and close > high[3] and close > high[4])

// Prev close > prev 9ema and current close < 9ema and 9ema < 20ma
isBearish = close[1] >= fast[1] and close < fast and fast < slow
// if (not isBearish and close < fast and close[1] > fast[1])
//     isBearish := close < open and close < low[1] and (close < low[2] or close < close[2]) // crossing 9ema from above

// Final bearish check, current close must be highest within 5 candle range
if (isBearish)
    isBearish := (close < close[1] and close < close[2] and close < close[3] and close < close[4])


plotshape(isBullish, title= "Bullish", location=location.belowbar, color=color.green, transp=0, style=shape.triangleup, text="")
plotshape(isBearish, title= "Bearish", location=location.abovebar, color=color.red, transp=0, style=shape.triangledown, text="")
// plot(top, color=color.yellow)
// plot(bot, color=color.yellow)

// edge = (close > slow) ? top : bot
// plot(edge, color=color.yellow)


// strategy("test")
// if bar_index > 4000
//     strategy.entry("buy", strategy.long, 10, when=strategy.position_size <= 0)
//     strategy.entry("sell", strategy.short, 10, when=strategy.position_size > 0)
// plot(strategy.equity)
