#! /usr/bin/env ruby

require 'pg'

db = PG.connect(dbname: 'expenses');

results = db.exec('SELECT id, created_on, amount, memo FROM expenses')

results.each do |row|
  columns = [ row["id"].rjust(3),
              row["created_on"].rjust(10),
              row["amount"].rjust(12),
              row["memo"] ]

  puts columns.join(" | ")
end

