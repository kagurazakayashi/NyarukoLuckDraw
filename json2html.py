#coding: utf-8
#!/usr/bin/python3
import os
import sys
from string import punctuation

htmlTemp: list[str] = [
    "<!DOCTYPE html><head><style>@font-face{font-family:'webfont';src:url('fonts/webfont.ttf');}body{font-family:'webfont';}</style></head><body>", "</body></html>"]
extWord: str = '尚未揭晓停止结束!恭喜抽奖者'


def loadtemp(file: str) -> str:
    f = open(file, 'r', encoding='UTF-8')
    lines: str = f.read()
    f.close()
    return lines


def cleardata(html: str) -> str:
    dicts = {i: '' for i in punctuation}
    punc_table = str.maketrans(dicts)
    return html.translate(punc_table)


def writehtml(html: str):
    fw = open("json2html.html", 'w', encoding='UTF-8')
    fw.write(html)
    fw.close()


html: str = extWord + loadtemp("data.json") + loadtemp("src/index.html")
html = cleardata(html)
html = htmlTemp[0] + html + htmlTemp[1]
writehtml(html)

print(sys.argv[0] + " OK.")
