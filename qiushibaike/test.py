#!/usr/bin/env python
# -*- coding=utf-8 -*-

import requests
from bs4 import BeautifulSoup

from lxml import  etree


page = 1
url = 'https://www.qiushibaike.com/text/'
user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
headers = {'User-Agent': user_agent}

response = requests.get(url=url)
soup = BeautifulSoup(response.content, 'lxml')
for content in soup.select('div[class="content"]'):
    print content
#
# # //*[@id="qiushi_tag_119166997"]/a/div
#
# print soup.select('#qiushi_tag_119166997 > a > div > span')

# selector = etree.HTML(response.content)
# contents = selector.xpath('//*[@id="qiushi_tag_119166997"]/a/div/span')
# print contents
