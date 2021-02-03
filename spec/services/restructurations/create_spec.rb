require 'spec_helper'

RSpec.describe LoanGenerator::Services::Restructurations::Create do

  let(:loan) do
    LoanGenerator::Standard.new(
      capital: capital,
      duration: duration,
      rate: rate,
      months_per_term: months_per_term,
      deferred: deferred,
    )
  end
  let(:capital) { 1000000 }
  let(:duration) { 12 }
  let(:rate) { 0.12 }
  let(:months_per_term) { 1 }
  let(:deferred) { 0 }

  subject { described_class.new.call(input) }
  let(:input) do
    {
      loan: loan,
      last_committed_term: last_committed_term
    }
  end

  let(:last_committed_term) { 6 }

  it 'succeeds' do
    s = subject.value!
    expect(subject.success?).to be true
  end

  # it 'picks the right time table' do
  #   expect(loan.time_tables[last_committed_term - 1].term).to eq(last_committed_term)
  # end

  # it 'has right remaining_capital' do
  #   expect(subject.value![:remaining_capital]).to eq(loan.time_tables[last_committed_term - 1].remaining_capital)
  # end

  # it 'has right paid_capital' do
  #   expect(subject.value![:paid_capital]).to eq(loan.time_tables[last_committed_term - 1].paid_capital)
  # end

  # it 'has right paid_interests' do
  #   expect(subject.value![:paid_interests]).to eq(loan.time_tables[last_committed_term - 1].paid_interests)
  # end

  # it 'has right capitalized_interests' do
  #   expect(subject.value![:capitalized_interests]).to eq(loan.time_tables[last_committed_term - 1].capitalized_interests)
  # end
end
