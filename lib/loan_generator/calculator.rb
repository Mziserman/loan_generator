module LoanGenerator
  class Calculator
    include Formulas

    attr_accessor :capital,
                  :duration,
                  :rate,
                  :months_per_term,
                  :deferred

    def initialize capital: 1000000, duration: 12, rate: 0.12, months_per_term: 1, deferred: 0
      @capital = capital.to_f
      @duration = duration
      @rate = rate
      @months_per_term = months_per_term
      @deferred = deferred
    end

    def total(term: 1)
      return interests_part(term: term) if term <= deferred

      capital_part(term: term) + interests_part(term: term)
    end

    def capital_part term: 1
      return 0 if term <= deferred
      return remaining_capital(term: term) if term == duration

      payment_per_term - interests_part(term: term)
    end

    def interests_part term: 1
      to_capitalize(term: term) * rate_per_term
    end

    def to_capitalize term: 1
      remaining_capital(term: term)
    end

    def remaining_capital term: 1
      capital - paid_capital(term: term)
    end

    def remaining_capital_end_of_term term: 1
      capital - paid_capital(term: term + 1)
    end

    def paid_capital term: 1
      return 0 if term == 1

      paid_capital(term: term - 1) + capital_part(term: term - 1)
    end

    def paid_capital_end_of_term term: 1
      paid_capital(term: term + 1)
    end

    def paid_interests term: 1
      return 0 if term == 1

      paid_interests(term: term - 1) + interests_part(term: term - 1)
    end

    def remaining_interests term: 1
      return total_interest if term == 1

      total_interest - paid_interests(term: term)
    end

    def paid_interests_end_of_term term: 1
      paid_interests(term: term + 1)
    end

    def remaining_interests_end_of_term term: 1
      remaining_interests(term: term + 1)
    end
  end
end
