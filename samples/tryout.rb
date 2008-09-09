#!/usr/bin/ruby
require 'yaml'
require '../lib/ucsc.rb'

ranges = Hash.new
File.open('ranges.txt').each do |line|
  line.chomp!
  chromosome, start, stop = line.split(/\t/)
  target_slice = Slice.new(chromosome, Range.new(start.to_i, stop.to_i))
  if ! ranges.keys.include?(chromosome)
    ranges[chromosome] = Array.new
  end
  ranges[chromosome].push(target_slice)
end

ranges.keys.each do |chromosome|
  all_annotations = Array.new

  ALL_CNPS.each do |klass|
    all_annotations.push(klass.find_all_by_chrom(chromosome))
  end

  ALL_REPEATS.each do |klass|
    all_annotations.push(klass.find_all_by_chrom(chromosome))
  end
  
  all_annotations.flatten!

  ranges[chromosome].each do |target_slice|
    all_annotations.each do |annotation|
      if annotation.slice.overlaps?(target_slice)
        puts target_slice.to_s + "\t" + annotation.to_s
      end
    end
  end
end
