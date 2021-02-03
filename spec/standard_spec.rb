require 'spec_helper'

RSpec.describe LoanGenerator::Standard do
  let(:loan) do
    described_class.new(
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

  context 'with default values' do
    it "initializes" do
      expect { loan }.not_to raise_error
    end

    it 'has right calculated term rate' do
      expect(loan.rate_per_term).to be_within(0.0005).of(0.009)
    end

    it 'has right payment per term' do
      expect(loan.payment_per_term).to be_within(0.1).of(88562.07)
    end
  end
end
