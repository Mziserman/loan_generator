module LoanGenerator
  class Standard
    include Formulas
    include PrintableLoan

    attr_accessor :capital,
                  :duration,
                  :rate,
                  :months_per_term,
                  :rate_per_term,
                  :payment_per_term,
                  :deferred,
                  :time_tables

    def initialize capital: 1000000, duration: 12, rate: 0.12, months_per_term: 1, deferred: 0
      @capital = capital.to_f
      @duration = duration
      @rate = rate
      @months_per_term = months_per_term
      @deferred = deferred
      @calculator = Calculator.new(
        capital: capital,
        duration: duration,
        rate: rate,
        months_per_term: months_per_term,
        deferred: deferred
      )

      @time_tables = generate_time_tables
    end

    def rate_per_term
      @calculator.rate_per_term
    end

    def payment_per_term
      @calculator.payment_per_term
    end

    def paid_capital term: 1
      time_tables[0...term].map(&:capital_part).sum
    end

    def paid_interests term: 1
      time_tables[0...term].map(&:interests_part).sum
    end

    def paid term: 1
      time_tables[0...term].map(&:total).sum
    end

    private

    def generate_time_tables
      (1..duration).map do |term|
        TimeTable.new(
          term: term,
          total: @calculator.total(term: term),
          capital_part: @calculator.capital_part(term: term),
          interests_part: @calculator.interests_part(term: term),
          paid_capital: @calculator.paid_capital_end_of_term(term: term),
          remaining_capital: @calculator.remaining_capital_end_of_term(term: term),
          paid_interests: @calculator.paid_interests_end_of_term(term: term),
          remaining_interests: @calculator.remaining_interests_end_of_term(term: term),
          capitalized_interests: @calculator.capitalized_interests(term: term)
        )
      end
    end
  end
end
