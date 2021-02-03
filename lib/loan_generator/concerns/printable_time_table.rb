module LoanGenerator
  module PrintableTimeTable
    def table_print(columns)
      columns.map { |column|
        value = send(column[:key])
        (column[:type] == 'float' ? '%.2f' % value.to_f.round(2) : value).to_s.rjust(column[:width])
      }.join(' | ')
    end
  end
end
