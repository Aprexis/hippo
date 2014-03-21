module Hippo::TransactionSets
  module HIPAA_277

    class L2100A < Hippo::TransactionSets::Base
      loop_name 'L2100A'    #Information Source Name

      #Information Source Name
      segment Hippo::Segments::NM1,
                :name           => 'Information Source Name',
                :minimum        => 1,
                :maximum        => 1,
                :position       => 500,
                :identified_by => {
                  'NM101' => ["AY", "PR"],
                  'NM102' => '2',
                  'NM108' => ["46", "FI", "PI", "XV"]
                }

      segment Hippo::Segments::PER,
              :name => 'Source Contact Information',
              :minimum => 1,
              :maximum => 1,
              :position => 1000,
              :identified_by => {
                  'PER01' => 'IC'
              }

    end
  end
end
