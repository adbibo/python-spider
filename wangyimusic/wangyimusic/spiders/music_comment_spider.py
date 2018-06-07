#!/usr/bin/env python
# -*- coding=utf-8 -*-

import scrapy


class MusicCommentSpider(scrapy.Spider):

    name = "music_comment_spider"
    allowed_domains = ["music.163.com"]
    start_urls = [
        "http://music.163.com/#/song?id=437292675",
    ]

    def parse(self, response):
        filename = response.url.split("/")[-2]
        with open(filename, 'wb') as f:
            f.write(response.body)
