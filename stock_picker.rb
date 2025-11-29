def stock_picker(prices)
  best_buy_day = 0
  best_sell_day = 0
  best_profit = 0

  prices.each_with_index do |buy_price, buy_day|
    (buy_day + 1...prices.length).each do |sell_day|
      profit = prices[sell_day] - buy_price

      if profit > best_profit
        best_profit = profit
        best_buy_day = buy_day
        best_sell_day = sell_day
      end
    end
  end

  [best_buy_day, best_sell_day]
end


print stock_picker([17,3,6,9,15,8,6,1,10])