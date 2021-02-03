require 'spec_helper'
require 'pry'

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
    expect(subject.success?).to be true
  end

  it 'generates the right number of time ables' do
    expect(subject.value!.time_tables.length).to eq(loan.duration - last_committed_term)
  end

  it 'does not change input loan' do
    time_tables = loan.time_tables
    subject

    time_tables.each_with_index do |time_table, index|
      expect(loan.time_tables[index]).to be == time_table
    end
  end

  it 'has right time tables' do
    subject.value!.time_tables.each_with_index do |time_table, index|
      base = loan.time_tables[index + last_committed_term]
      expect(base.total).to be_within(0.004).of(time_table.total)
      expect(base.capital_part).to be_within(0.004).of(time_table.capital_part)
      expect(base.interests_part).to be_within(0.004).of(time_table.interests_part)
      expect(base.paid_capital).to be_within(0.004).of(time_table.paid_capital)
      expect(base.remaining_capital).to be_within(0.004).of(time_table.remaining_capital)
      expect(base.paid_interests).to be_within(0.004).of(time_table.paid_interests)
      expect(base.remaining_interests).to be_within(0.004).of(time_table.remaining_interests)
      expect(base.capitalized_interests).to be_within(0.004).of(time_table.capitalized_interests)
    end
  end

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
