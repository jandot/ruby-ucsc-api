#
# = test/unit/test_activerecord.rb - Unit test for Ucsc::Hg18
#
# Copyright::   Copyright (C) 2008
#               Jan Aerts <jan.aerts@gmail.com>
# License::     Ruby's
#
# $Id:
require 'pathname'
libpath = Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 2, 'lib')).cleanpath.to_s
$:.unshift(libpath) unless $:.include?(libpath)

require 'test/unit'

require 'ucsc'

include Ucsc::Hg18

# Let's see if we can 'find' things
class SimpleRecordsTest < Test::Unit::TestCase
  def test_iafrage
    assert_equal('CTC-232B23', CnpIafrate.find_by_name('CTC-232B23').name)
  end

  def test_locke
    assert_equal('RP11-430E19', CnpLocke.find_by_name('RP11-430E19').name)
  end

  def test_redon
    assert_equal('cnp1', CnpRedon.find_by_name('cnp1').name)
  end

  def test_sebat
    assert_equal(1, CnpSebat.find_all_by_chrom_and_chromStart('chr1',12826893).length)
  end

  def test_sharp
    assert_equal('RP11-430E19', CnpSharp.find_by_name('RP11-430E19').name)
  end

  def test_tuzun
    assert_equal('chr1.1', CnpTuzun.find_by_name('chr1.1').name)
  end

  def test_dgv
    assert_equal('31596', Dgv.find_by_name('31596').name)
  end

  def test_simple_repeats
    assert_equal('TAACCC', SimpleRepeat.find_by_chrom_and_chromStart('chr1', 0).sequence)
  end
  
  def test_genomic_super_dup
    assert_equal('chr2:114046768', GenomicSuperDup.find_by_chrom_and_chromStart('chr1',465).name)
  end
  
  def test_exapted_repeat
    assert_equal(3180908, ExaptedRepeat.find_by_name('exap1').chromStart)
  end

#  def test_repeatmasker
#    
#  end
  
  def test_interrupted_repeat
    assert_equal('L2', InterruptedRepeat.find_by_chrom_and_chromStart('chr1',13687).name)
  end
  
  def test_microsatellite
    assert_equal('16xGT', Microsatellite.find_by_chrom_and_chromStart('chr1', 40344).name)
  end
end

class MixinsTest < Test::Unit::TestCase
  def test_feature
    assert_equal(true, CnpIafrate.include?(Feature))
    assert_equal(true, CnpLocke.include?(Feature))
    assert_equal(true, CnpRedon.include?(Feature))
    assert_equal(true, CnpSebat.include?(Feature))
    assert_equal(true, CnpSharp.include?(Feature))
    assert_equal(true, CnpTuzun.include?(Feature))
    assert_equal(true, Dgv.include?(Feature))
  end
  
  def test_sliceable
    assert_equal(true, CnpIafrate.include?(Sliceable))
    assert_equal(true, CnpLocke.include?(Sliceable))
    assert_equal(true, CnpRedon.include?(Sliceable))
    assert_equal(true, CnpSebat.include?(Sliceable))
    assert_equal(true, CnpSharp.include?(Sliceable))
    assert_equal(true, CnpTuzun.include?(Sliceable))
    assert_equal(true, Dgv.include?(Sliceable))
  end
end