import requests
from bs4 import BeautifulSoup

url = 'https://www.drikpanchang.com/muhurat/choghadiya.html?geoname-id=5375480'
chogadiya_selector = "body > div.dpPageWrapper > div.dpInnerWrapper > div.dpPHeaderWrapper > div.dpPHeaderContent.dpFlex > div.dpPHeaderLeftWrapper > div.dpPHeaderLeftContent.dpFlex > div:nth-child(2) > div.dpPHeaderLeftTitle"
time_selector = "body > div.dpPageWrapper > div.dpInnerWrapper > div.dpPHeaderWrapper > div.dpPHeaderContent.dpFlex > div.dpPHeaderLeftWrapper > div.dpPHeaderLeftContent.dpFlex > div:nth-child(2) > div:nth-child(2)"

response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

chogadiya = soup.select_one(chogadiya_selector).get_text()
time = soup.select_one(time_selector).get_text()

def get_chogadiya_color(chogadiya: str) -> str:
    color = "#808080"
    if chogadiya in set(['shubha', 'labha', 'amrita']):
        color =  "#4E9A06"
    elif chogadiya in set(['roga', 'udvega', 'kala']):
        color = "#CC0000"
    return color

print(f"{chogadiya} | {time.replace(' to ', '-- ').replace('PM', '').replace('AM', '')}")
print(f"{get_chogadiya_color(chogadiya.split(' ')[0].lower())}")
