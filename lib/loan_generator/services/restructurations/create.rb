require "dry/transaction"

module LoanGenerator
  module Services
    module Restructurations
      class Create
        include Dry::Transaction

        tee :params
        step :fetch_infos
        step :create

        private

        def params(input)
          @loan = input[:loan]
          @last_committed_term = input[:last_committed_term]
          raise ArgumentError.new if @last_committed_term >= @loan.duration

          @duration = input.fetch(:months_per_term,
            @loan.duration - @last_committed_term
          )
          @rate = input.fetch(:rate, @loan.rate)
          @months_per_term = input.fetch(:months_per_term, @loan.months_per_term)
          @rate_per_term = input.fetch(:rate_per_term, @loan.rate_per_term)
          @payment_per_term = input.fetch(:payment_per_term, @loan.payment_per_term)
          @deferred = input.fetch(:deferred,
            [@loan.deferred - @last_committed_term, 0].max
          )
        end

        def fetch_infos(input)
          infos = Infos.new.call(loan: @loan, last_committed_term: @last_committed_term)

          if infos.success?
            @remaining_capital = infos.value![:remaining_capital]
            @paid_capital = infos.value![:paid_capital]
            @paid_interests = infos.value![:paid_interests]
            @capitalized_interests = infos.value![:capitalized_interests]
            Success(input)
          else
            infos
          end
        end

        def create(input)
          new_loan = Standard.new(new_loan_params)
          new_loan.ancestor = @loan
          new_loan.restructuration_params = new_loan_params
          Success(new_loan)
        end

        def new_loan_params
          {
            capital: @loan.capital,
            duration: @duration,
            rate: @rate,
            months_per_term: @months_per_term,
            deferred: @deferred,
            paid_capital: @paid_capital,
            paid_interests: @paid_interests,
            capitalized_interests: @capitalized_interests
          }
        end
      end
    end
  end
end
