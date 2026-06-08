colors = ["#4E6583", "#EC7C00", "#777E91", "#ACB0BB"]
colf = "#EEC295"

count = 68 * 25 / colors.len

for i in range(0, count - 1)
	for col in colors
		text.backColor = color.lerp(col, colf, i / count)
		print " ", ""
	end for
end for