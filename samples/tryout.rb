#!/usr/bin/ruby
require 'yaml'
require '../lib/ucsc.rb'

all_cnvs = Array.new
[Dgv, CnpIafrate, CnpLocke, CnpRedon, CnpSebat, CnpSharp, CnpTuzun].each do |klass|
  all_cnvs.push(klass.find_all_by_chrom('chrX'))
end

all_cnvs.flatten!

File.open('ranges_chrX.txt').each do |line|
  line.chomp!
  start, stop = line.split(/\t/)
  target_slice = Slice.new('chrX', Range.new(start.to_i, stop.to_i))
  puts target_slice.to_s
  all_cnvs.each do |cnv|
    if cnv.slice.overlaps?(target_slice)
      puts "\t" + cnv.to_s
    end
  end
end

