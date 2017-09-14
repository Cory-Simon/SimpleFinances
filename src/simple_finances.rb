#!/usr/bin/env ruby

require 'sqlite3'

class SimpleFinances

  def initialize
    initialize_db
    menu
  end

  def initialize_db
    puts 'SQLite3 is installed.' if defined?(SQLite3::Database)
    $db = SQLite3::Database.new('../data/dbfile')
    $db.results_as_hash = true

    if $db.table_info('transactions').empty?
      puts 'Creating the transaction table'
      $db.execute %q{
      CREATE TABLE transactions (
      id integer primary key,
      date date,
      amount float,
      category varchar(50),
      payee varchar(50),
      account varchar(20))
      }
    end
  end


  def disconnect_and_quit
    $db.close
    puts 'Bye!'
    exit
  end

  def get_input
    gets.chomp # difference betweein .strip?
  end

  def menu
    input = ''
    until input == 'q'
      print_menu
      input = get_input
      puts input
      case input
        when 'q'
          disconnect_and_quit
        when 'n'
          new_transaction
      end
    end
  end

  def print_menu
    puts 'n:  new debit/credit'
    puts 'q:  quit'
    print 'enter selection: '
  end

  def new_transaction
    print 'Date: '
    date = Time.new.to_date unless get_input
    puts date.to_s
    print 'Amount: '
    amount = get_input
    print 'Category: '
    category = get_input
    print 'Payee: '
    payee = get_input
    print 'Account: '
    account = get_input

    puts "#{date} | #{amount} | #{category} | #{payee} | #{account}"

  end
end

if __FILE__ == $0
  SimpleFinances.new
end
