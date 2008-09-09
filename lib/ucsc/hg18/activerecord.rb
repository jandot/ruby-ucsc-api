#
# = ucsc/hg18/activerecord.rb - ActiveRecord mappings to UCSC hg18 database
#
# Copyright::   Copyright (C) 2008 Jan Aerts <jan.aerts@gmail.com>
# License::     The Ruby License
#

# = DESCRIPTION
# == What is it?
# The UCSC module provides an API to the UCSC databases
# stored at genome-mysql.cse.ucsc.edu. This is the same information that is
# available from http://genome.ucsc.edu
#
# The Ucsc::Hg18 module covers the hg18 (= NCBI build 36) assembly.
#
# == ActiveRecord
# The UCSC API provides a ruby interface to the UCSC mysql databases
# at genome-mysql.cse.ucsc.edu. Most of the API is based on ActiveRecord to
# get data from that database. In general, each table is described by a
# class with the same name: the cnpRedon table is covered by the
# CnpRedon class, the dgv table is covered by the Dgv class,
# etc. As a result, accessors are available for all columns in each table.
# For example, the cnpRedon table has the following columns: chrom, chromStart, 
# chromEnd and name. Through ActiveRecord, these column names become available 
# as attributes of CnpRedon objects:
#   puts my_cnp_redon.name
#   puts my_cnp_redon.chrom
#   puts my_cnp_redon.chromStart
#   puts my_cnp_redon.chromEnd
#
# ActiveRecord makes it easy to extract data from those tables using the
# collection of #find methods. There are three types of #find methods (e.g.
# for the CnpRedon class):
# a. find based on primary key in table:
#  # not possible with the UCSC database
# b. find_by_sql:
#  my_cnp = CnpRedon.find_by_sql('SELECT * FROM cnpRedon WHERE name = 'cnp1'")
# c. find_by_<insert_your_column_name_here>
#  my_cnp = CnpRedon.find_by_name('cnp1')
#  my_cnp2 = CnpRedon.find_by_chrom_and_chromStart('chr1',377)
# To find out which find_by_<column> methods are available, you can list the
# column names using the column_names class methods:
#
#  puts Ucsc::Hg18::CnpRedon.column_names.join("\t")
#
# For more information on the find methods, see
# http://ar.rubyonrails.org/classes/ActiveRecord/Base.html#M000344
#
module Ucsc
  # = DESCRIPTION
  # The Ucsc::Hg18 module covers the hg18 database from
  # genome-mysql.cse.ucsc.edu and covers mainly sequences and their annotations.
  # For a more information about the database tables, click on the "Describe 
  # table schema" in the Table Browser.
  module Hg18
    # = DESCRIPTION
    # The Sliceable mixin holds the get_slice method and can be included
    # in any class that lends itself to having a position on a chromosome.
    module Sliceable
      def slice
        start, stop, strand = nil, nil, nil
      	if self.class.column_names.include?('chromStart')
          start = self.chromStart
        end
      	if self.class.column_names.include?('chromEnd')
          stop = self.chromEnd
        end
      	if self.class.column_names.include?('strand')
          strand = self.strand
        end
      
        return Ucsc::Hg18::Slice.new(self.chrom, Range.new(start.to_i, stop.to_i), strand)
      end
    end
    
    # = DESCRIPTION
    # The Feature mixin holds common methods for all feature-like classes, such 
    # as how to print itself to the screen.
    module Feature
      include Sliceable
      
      def to_s
        return self.class.to_s + "\t" + self.slice.to_s + "\t" + self.name
      end
    end
    
    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "All hybridizations were performed in duplicate incorporating a 
    # dye-reversal using proprietary 1 Mb GenomeChip V1.2 Human BAC Arrays 
    # consisting of 2,632 BAC clones (Spectral Genomics, Houston, TX). The 
    # false positive rate was estimated at ~1 clone per 5,264 tested."
    class CnpIafrate < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'cnpIafrate2'
      set_primary_key nil
    end

    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "DNA samples were obtained from Coriell Cell Repositories. The reference 
    # DNA used for all hybridizations was from a single male of Czechoslovakian 
    # descent, Coriell ID GM15724 (also used in the Sharp study).
    # 
    # A locus was considered a CNV (copy number variation) if the log ratio of 
    # fluroescence measurements for the individuals assayed exceeded twice the 
    # standard deviation of the autosomal clones in replicate dye-swapped 
    # experiments. A CNV was classified as a CNP if altered copy number was 
    # observed in more than 1% of the 269 individuals."
    class CnpLocke < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'cnpLocke'
      set_primary_key nil
    end

    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "Experiments were performed with the International HapMap DNA and 
    # cell-line collection using two technologies: comparative analysis of 
    # hybridization intensities on Affymetric GeneChip Human Mapping 500K early 
    # access arrays (500K EA) and comparative genomic hybridization with a 
    # Whole Genome TilePath (WGTP) array."
    class CnpRedon < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'cnpRedon'
      set_primary_key nil
    end

    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "Following digestion with BglII or HindIII, genomic DNA was hybridized to 
    # a custom array consisting of 85,000 oligonucleotide probes. The probes 
    # were selected to be free of common repeats and have unique homology 
    # within the human genome. The average resolution of the array was ~35kb; 
    # however, only intervals in which three consecutive probes showed 
    # concordant signals were scored as CNPs. All hybridizations were performed 
    # in duplicate incorporating a dye-reversal, with the false positive rate 
    # estimated to be ~6%."
    class CnpSebat < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'cnpSebat2'
      set_primary_key nil
    end

    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "All hybridizations were performed in duplicate incorporating a 
    # dye-reversal using a custom array consisting of 2,194 end-sequence or 
    # FISH-confirmed BACs, targeted to regions of the genome flanked by 
    # segmental duplications. The false positive rate was estimated at ~3 
    # clones per 4,000 tested."
    class CnpSharp < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'cnpSharp2'
      set_primary_key nil
    end

    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "Paired-end sequences from a human fosmid DNA library were mapped to the 
    # assembly. The average resolution of this technique was ~8kb, and included 
    # 56 sites of inversion not detectable by the array-based approaches. 
    # However, because of the physical constraints of fosmid insert size, this 
    # technique was unable to detect insertions greater than 40 kb in size."
    class CnpTuzun < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'cnpTuzun'
      set_primary_key nil
    end
    
    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # ""
    class Dgv < DBConnection
      include Ucsc::Hg18::Feature
      
      set_table_name 'dgv'
      set_primary_key nil
      
      def to_s
        return self.class.to_s + "\t" + self.slice.to_s + "\t" + self.reference + "\t" + self.method
      end
    end
    
    
    # = DESCRIPTION
    # From Simple Repeats description page when clicking the "Describe 
    # table schema" in the table browser:
    # "This track displays simple tandem repeats (possibly imperfect) located 
    # by Tandem Repeats Finder (TRF), which is specialized for this purpose. 
    # These repeats can occur within coding regions of genes and may be quite 
    # polymorphic. Repeat expansions are sometimes associated with specific 
    # diseases."
    class SimpleRepeat < DBConnection
      include Sliceable
      
      set_table_name 'simpleRepeat'
      set_primary_key nil
    end
    
    # = DESCRIPTION
    # From Structural Variants description page when clicking the "Describe 
    # table schema" in the table browser:
    # "This track shows regions detected as putative genomic duplications 
    # within the golden path. The following display conventions are used to 
    # distinguish levels of similarity:
    #   * Light to dark gray: 90 - 98% similarity
    #   * Light to dark yellow: 98 - 99% similarity
    #   * Light to dark orange: greater than 99% similarity
    #   * Red: duplications of greater than 98% similarity that lack sufficient 
    #   Segmental Duplication Database evidence (most likely missed overlaps) 
    # For a region to be included in the track, at least 1 Kb of the total 
    # sequence (containing at least 500 bp of non-RepeatMasked sequence) had 
    # to align and a sequence identity of at least 90% was required."
    class GenomicSuperDup < DBConnection
      include Sliceable
      
      set_table_name 'genomicSuperDups'
      set_primary_key nil
    end
  end
end