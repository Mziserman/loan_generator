module LoanGenerator
  class Standard
    include Formulas

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

    private

    def generate_time_tables
      (1..duration).map do |term|
        TimeTable.new(
          term: term,
          total: @calculator.total(term: term),
          capital_part: @calculator.capital_part(term: term),
          interests_part: @calculator.interests_part(term: term)
        )
      end
    end
  end
end
