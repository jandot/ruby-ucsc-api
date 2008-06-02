module Ucsc
  module Hg18
    class Slice
      def initialize(chromosome, range, strand = nil)
        @chromosome, @range = chromosome, range, strand
      end
      attr_accessor :chromosome, :range, :strand
      
      def to_s
        return @chromosome + ':' + @range.to_s
      end
      
      def overlaps?(other_slice)
        if self.chromosome != other_slice.chromosome
          return false
        end
        
        if self.range.overlaps?(other_slice.range)
          return true
        else
          return false
        end
      end
      
      def contained_by?(other_slice)
        if self.chromosome != other_slice.chromosome
          return false
        end
        
        if self.range.contained_by?(other_slice.range)
          return true
        else
          return false
        end
      end
      
      def contains?(other_slice)
        if self.chromosome != other_slice.chromosome
          return false
        end
        
        if self.range.contains?(other_slice.range)
          return true
        else
          return false
        end
      end
    end
  end
end
