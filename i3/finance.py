import requests
from bs4 import BeautifulSoup

urls = ["https://www.cnbc.com/quotes/%40SI.1",
       "https://www.cnbc.com/quotes/%40GC.1",
       "https://www.cnbc.com/quotes/INR="]

selector = "#quote-page-strip > div.QuoteStrip-dataContainer > div.QuoteStrip-lastTimeAndPriceContainer > div.QuoteStrip-lastPriceStripContainer > span.QuoteStrip-lastPrice"
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36'}

def get_price(url):
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.content, 'html.parser')
    try:
        price = soup.select_one(selector).get_text()
    except:
        price = 0
    price = price.replace(",", "")
    return float(price)

prices = [get_price(url) for url in urls]
prices_sanitized = list(map(str, [int(p * 100) / 100 for p in prices]))
icons = ['🥈: ', '🥇: ', '$->₹: ']
final_str = ' | '.join([icons[i] + prices_sanitized[i] for i in range(len(prices))])
print(final_str)
