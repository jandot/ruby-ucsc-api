require 'rubygems'
require 'activerecord'


module Ucsc
  DB_ADAPTER = 'mysql'
  DB_HOST = 'genome-mysql.cse.ucsc.edu'
  DB_USERNAME = 'genome'
  DB_PASSWORD = ''

  module Hg18
    # = DESCRIPTION
    # The Ucsc::Hg18::DBConnection is the actual connection established
    # with the UCSC mysql server.
    class DBConnection < ActiveRecord::Base
      self.abstract_class = true

      # = DESCRIPTION
      # The Ucsc::Hg18::DBConnection#connect method makes the connection
      # to the UCSC hg18 database.
      #
      # = USAGE
      #  # Connect to the hg18
      #  Ensembl::Core::DBConnection.connect
      #
      # ---
      # *Arguments*: none
      def self.connect
        establish_connection(
                            :adapter => Ucsc::DB_ADAPTER,
                            :host => Ucsc::DB_HOST,
                            :database => 'hg18',
                            :username => Ucsc::DB_USERNAME,
                            :password => Ucsc::DB_PASSWORD
                            )
        end

      end

    end

  end
