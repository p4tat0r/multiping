require 'open3'
require 'ostruct'

sites = ['google.com','perdu.com','laredoute.fr','yahoo.com','xkcd.com','arstechnica.com','www.wired.com','sfr.fr','actu.fr','wanadoo.fr']
results = []

for el in sites do
	Open3.popen3("ping -n 1 " + el) do |stdin, stdout, stderr|
		# This is the only way to not have the error "in `[]': invalid byte sequence in UTF-8 (ArgumentError)"
		@output = stdout.read.force_encoding("ISO-8859-1").encode('utf-8')
	end
	# Extract only the second group which we are interested in
	latency = @output[/(Moyenne = )([0-9]+)(ms)/, 2]
	tuple = OpenStruct.new
	tuple.site = el
	tuple.latency = latency.to_i
	results.push(tuple)
end
# Sorting by latency
results = results.sort_by { |i| i.latency}

# Displaying the result
for el in results do
	puts el.site + ' = ' + el.latency.to_s + ' ms'
end