require "optparse"
opt = OptionParser.new
params = {}

opt.on("-y"){|v| v }
opt.on("-m"){|v| v }

opt.parse!(ARGV, into: params)

p ARGV
p params
