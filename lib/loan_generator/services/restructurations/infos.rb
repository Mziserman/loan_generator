require "dry/transaction"

module LoanGenerator
  module Services
    module Restructurations
      class Infos
        include Dry::Transaction

        tee :params
        step :infos

        private

        def params(input)
          @loan = input[:loan]
          @last_committed_term = input[:last_committed_term]
          raise ArgumentError.new if @last_committed_term >= @loan.duration
        end

        def infos(input)
          time_table = @loan.time_tables[@last_committed_term - 1]
          Success(
            remaining_capital: time_table.remaining_capital,
            paid_capital: time_table.paid_capital,
            paid_interests: time_table.paid_interests,
            capitalized_interests: time_table.capitalized_interests
          )
        end
      end
    end
  end
end
