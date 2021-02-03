module LoanGenerator
  module Formulas
    def payment_per_term
      (
        (base_capitalized_interests + capital - base_paid_capital) * rate_per_term * (1 + rate_per_term)**(duration - deferred)
      ) / (
        (1 + rate_per_term)**(duration - deferred) - 1
      )
    end

    def rate_per_term
      ((1 + rate)**(months_per_term / 12.0)) - 1
    end

    def total_interest
      base_paid_interests + payment_per_term * duration - (capital - base_paid_capital)
    end

    def capitalized_interests(term: 1)
      # term = [term, complete_deferred].min
      term = [term, 0].min # don't have complete deferred yet
      capital * (1 + rate_per_term)**term - capital
    end
  end
end
