import codecs

a = codecs.open("random.tsv", "r", "unicode-escape").read() # a is a unicode object

codecs.open("output.tsv", "w", "utf8").write(a)

