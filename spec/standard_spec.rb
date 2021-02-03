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

  it "initializes" do
    expect { loan }.not_to raise_error
  end

  it 'has right calculated term rate' do
    expect(loan.rate_per_term).to be_within(0.00004).of(0.0095)
  end

  it 'has right payment per term' do
    expect(loan.payment_per_term).to be_within(0.004).of(88562.07)
  end

  it 'reimburse all capital' do
    expect(loan.time_tables.map(&:capital_part).sum).to be_within(0.004).of(
      capital
    )
  end

  context 'with deferred' do
    let(:deferred) { 6 }

    let(:model) do
      described_class.new(
        capital: capital,
        duration: 6,
        rate: rate,
        months_per_term: months_per_term,
        deferred: 0,
      )
    end

    it 'has right calculated term rate' do
      expect(loan.rate_per_term).to be_within(0.00004).of(0.0095)
    end

    it 'reimburse all capital' do
      expect(loan.time_tables.map(&:capital_part).sum).to be_within(0.004).of(
        capital
      )
    end

    it 'has right calculated term rate' do
      expect(loan.payment_per_term).to eq(model.payment_per_term)
    end
  end

  context 'with 3 months per terms' do
    let(:months_per_term) { 3 }
    let(:duration) { 4 }

    it 'has right calculated term rate' do
      expect(loan.rate_per_term).to be_within(0.00004).of(0.0287)
    end

    it 'reimburse all capital' do
      expect(loan.time_tables.map(&:capital_part).sum).to be_within(0.004).of(
        capital
      )
    end

    it 'has right calculated payment per term' do
      expect(loan.payment_per_term).to be_within(0.004).of(268215.22)
    end

    context 'with deferred' do
      let(:deferred) { 2 }

      let(:model) do
        described_class.new(
          capital: capital,
          duration: 2,
          rate: rate,
          months_per_term: months_per_term,
          deferred: 0,
        )
      end

      it 'has right calculated term rate' do
        expect(loan.rate_per_term).to be_within(0.00004).of(0.0287)
      end

      it 'reimburse all capital' do
        expect(loan.time_tables.map(&:capital_part).sum).to be_within(0.004).of(
          capital
        )
      end

      it 'has right calculated term rate' do
        expect(loan.payment_per_term).to eq(model.payment_per_term)
      end
    end
  end
end
