module LoanGenerator
  module PrintableLoan
    COLUMNS = [
      {
        key: 'term',
        title: 't.',
        type:'integer'
      },
      {
        key: 'capital_part',
        title: 'capital',
        type: 'float'
      },
      {
        key: 'interests_part',
        title: 'interests_part',
        type: 'float'
      },
      {
        key: 'paid_capital',
        title: 'paid_capital',
        type: 'float'
      },
      {
        key: 'remaining_capital',
        title: 'remaining_capital',
        type: 'float'
      },
      {
        key: 'paid_interests',
        title: 'paid_interests',
        type: 'float'
      },
      {
        key: 'remaining_interests',
        title: 'remaining_interests',
        type: 'float'
      },
      {
        key: 'capitalized_interests',
        title: 'cap. interests',
        type: 'float'
      },
      {
        key: 'total',
        title: 'total',
        type: 'float'
      }
    ]

    def table_print
      columns = COLUMNS.map do |column|
        {
          width: max_width_for_column(column),
          **column
        }
      end

      puts [columns.map { |column| column[:title].rjust(column[:width]) }.join(' | ')] +
      time_tables.map { |record|
        record.table_print(columns)
      }
    end
    alias tp table_print

    def max_width_for_column(column)
      [
        time_tables.map do |time_table|
          value = time_table.send(column[:key])
          (column[:type] == 'float' ? '%.2f' % value.to_f.round(2) : value).to_s.length
        end.max,
        column[:title].length
      ].max
    end
  end
end
