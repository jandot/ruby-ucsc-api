begin
  require 'rubygems'
  require 'bio'
  rescue LoadError
    raise LoadError, "You must have bioruby installed"
end

class Range
  def contained_by?(other_range)
    if self.begin > other_range.begin and self.end < other_range.end
      return true
    else
      return false
    end
  end
  
  def overlaps?(other_range)
    if ((self.begin >= other_range.begin and self.begin <= other_range.end) or (other_range.begin >= self.begin and other_range.begin <= self.end))
      return true
    else
      return false
    end
  end
end

# Database connection
require File.dirname(__FILE__) + '/ucsc/db_connection.rb'
include Ucsc::Hg18
Ucsc::Hg18::DBConnection.connect

# Core modules
require File.dirname(__FILE__) + '/ucsc/hg18/activerecord.rb'
require File.dirname(__FILE__) + '/ucsc/hg18/slice.rb'

module Ucsc
  ALL_CNPS = [Dgv, CnpIafrate, CnpLocke, CnpRedon, CnpSebat, CnpSharp, CnpTuzun]
  SEGDUPS = [GenomicSuperDup]
  ALL_REPEATS = [SimpleRepeat, ExaptedRepeat, InterruptedRepeat, Microsatellite]
end
