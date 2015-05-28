import codecs

a = codecs.open("searchAll.tsv", "r", "unicode-escape").read() # a is a unicode object

codecs.open("output.tsv", "w", "utf8").write(a)

