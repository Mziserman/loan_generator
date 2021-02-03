module LoanGenerator
  module Trackable
    attr_accessor :ancestor, :children, :restructuration_params

    def ancestors
      return unless ancestor.present?

      ancestor.ancestors + ancestor
    end
  end
end
