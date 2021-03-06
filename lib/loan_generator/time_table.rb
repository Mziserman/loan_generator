module LoanGenerator
  class TimeTable
    include PrintableTimeTable

    attr_reader :term,
                :total,
                :capital_part,
                :interests_part,
                :paid_capital,
                :remaining_capital,
                :paid_interests,
                :remaining_interests,
                :capitalized_interests

    def initialize(
      term: 1,
      total: 0,
      capital_part: 0,
      interests_part: 0,
      paid_capital: 0,
      remaining_capital: 0,
      paid_interests: 0,
      remaining_interests: 0,
      capitalized_interests: 0
    )
      @term = term
      @total = total
      @capital_part = capital_part
      @interests_part = interests_part
      @paid_capital = paid_capital
      @remaining_capital = remaining_capital
      @paid_interests = paid_interests
      @remaining_interests = remaining_interests
      @capitalized_interests = capitalized_interests
    end

    def == other
      return false unless other.is_a? TimeTable

      return false unless other.term == term
      return false unless other.total == total
      return false unless other.capital_part == capital_part
      return false unless other.interests_part == interests_part
      return false unless other.paid_capital == paid_capital
      return false unless other.remaining_capital == remaining_capital
      return false unless other.paid_interests == paid_interests
      return false unless other.remaining_interests == remaining_interests
      return false unless other.capitalized_interests == capitalized_interests

      true
    end
  end
end
