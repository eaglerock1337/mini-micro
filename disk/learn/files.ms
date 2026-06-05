p = file.curdir
for f in file.children(p).sort
	info = file.info(file.child(p, f))
	padName = (f + " " * 40)[:40]
	padSize = (" " * 8 + info.size)[-8:]
	print padName + padSize + " " + info.date
end for