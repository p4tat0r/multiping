import re
import subprocess

sites = ['google.com','perdu.com','laredoute.fr','yahoo.com','xkcd.com','arstechnica.com','www.wired.com','sfr.fr','actu.fr','wanadoo.fr']
results = []

# Extracting data from ping and putting it in an array of tuples
for el in sites:
	cmd = "ping -n 1 " + el
	output = subprocess.check_output(cmd)
	output = ''.join(map(chr, output))
	latencies = re.search(r"([0-9]+)ms\r\n$", output)
	results.append((el, latencies.group(1)))

# Sorting the array by the latency of each site
results.sort(key = lambda x: float(x[1]), reverse = False)

# Displaying the result
for i in results:
	print(i[0], "=", i[1], "ms")
