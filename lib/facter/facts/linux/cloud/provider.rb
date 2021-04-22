# frozen_string_literal: true

module Facts
  module Linux
    module Cloud
      class Provider
        FACT_NAME = 'cloud.provider'

        def initialize
          @virtual = Facter::Util::Facts::Posix::VirtualDetector.new
        end

        def call_the_resolver
          provider = case @virtual.platform
                     when 'hyperv'
                       'azure' unless Facter::Resolvers::Az.resolve(:metadata).empty?
                     end

          Facter::ResolvedFact.new(FACT_NAME, provider)
        end
      end
    end
  end
end
