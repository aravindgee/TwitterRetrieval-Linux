import codecs

a = codecs.open("output.tsv", "r", "unicode-escape").read() # a is a unicode object

codecs.open("final.tsv", "w", "utf8").write(a)

