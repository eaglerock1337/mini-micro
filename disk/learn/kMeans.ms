import "mathUtil"
import "listUtil"

clear

Datum = new Sprite
Datum.image = file.loadImage("/sys/pics/shapes/Circle.png")
Datum.scale = 0.2

Cluster = new Sprite
Cluster.image = file.loadImage("/sys/pics/X0/X-white.png")
Cluster.scale = 0.2

// Define the number of data points (n) and centroids (k).
n = 40
k = 4

// Create some random data points.
data = []
for i in range(1, n)
	d = new Datum
	d.x = round(960 * rnd)  // screen width
	d.y = round(640 * rnd)  // screen height
	display(4).sprites.push d  // display 4 - sprite display
	data.push d
end for

// Create the centroids, also in random positions.
centroids = []
colors = [color.orange, color.aqua, color.fuchsia, color.lime]
for i in range(1, k)
	c = new Cluster
	c.tint = colors[i-1]
	c.x = round(960 * rnd)
	c.y = round(640 * rnd)
	display(4).sprites.push c
	centroids.push c
end for

// Update all data points by assigning them to the nearest centroid
// also update dataX and dataY lists within each centroid
updateData = function
	for c in centroids
		c.dataX = []
		c.dataY = []
	end for
	for d in data
		bestCluster = null
		for c in centroids
			dist = mathUtil.distance(d, c)
			if bestCluster == null or dist < bestDist then
				bestCluster = c
				bestDist = dist
			end if
		end for
		d.tint = bestCluster.tint
		bestCluster.dataX.push d.x
		bestCluster.dataY.push d.y
	end for
end function

// Update the centroids by moving them to the average position
// of the data points assigned to them
updateClusters = function
	for c in centroids
		if not c.dataX then continue
		oldX = c.x
		oldY = c.y
		c.x = c.dataX.mean
		c.y = c.dataY.mean
		if oldX != c.x or oldY != c.y then globals.changed = true
	end for
end function

// Repeat those steps until done!
changed = true
while changed
	changed = false
	updateData
	updateClusters
	wait
end while

print "Totals:"
for i in range(0, k-1)
	text.color = colors[i]
	print centroids[i].dataX.len
end for
