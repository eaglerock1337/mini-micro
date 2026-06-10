import "mapUtil"
import "listUtil"

// load the word list
words = file.readLines("/sys/data/englishWords.txt")

// convert all words to uppercase
for i in words.indexes
	words[i] = words[i].upper
end for

// count the frequency of each letter
print "Analyzing words..."
counts = {}  // key: letter; value: count
for word in words
	for letter in word
		counts[letter] = counts.get(letter, 0) + 1
	end for
end for
print counts