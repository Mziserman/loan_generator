require "loan_generator/version"
require 'loan_generator/concerns/formulas'
require 'loan_generator/concerns/printable_loan'
require 'loan_generator/concerns/printable_time_table'
require 'loan_generator/calculator'
require 'loan_generator/standard'
require 'loan_generator/time_table'
require 'loan_generator/version'

module LoanGenerator
  class Error < StandardError; end
end
