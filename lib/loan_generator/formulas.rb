module LoanGenerator
  module Formulas
    def calculate_payment_per_term
      (
        capital * rate_per_term * (1 + rate_per_term)**(duration - deferred)
      ) / (
        (1 + rate_per_term)**(duration - deferred) - 1
      )
    end

    def calculate_rate_per_term
      ((1 + rate)**(months_per_term / 12.0)) - 1
    end
  end
end
