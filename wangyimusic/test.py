#!/usr/bin/env python
# -*- coding=utf-8 -*-

"""
 @author 
 @create 2017-04-08 下午10:10
"""

import requests
from scrapy.selector import Selector

test_request = requests.get('http://music.163.com/#/song?id=437292675')

body = test_request.content
print type(body)
print body
print Selector(text=body).xpath('//*[@id="auto-id-INeUsGybS7XyACVk"]')

