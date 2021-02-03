module LoanGenerator
  module Formulas
    def payment_per_term
      (
        capital * rate_per_term * (1 + rate_per_term)**(duration - deferred)
      ) / (
        (1 + rate_per_term)**(duration - deferred) - 1
      )
    end

    def rate_per_term
      ((1 + rate)**(months_per_term / 12.0)) - 1
    end
  end
end
