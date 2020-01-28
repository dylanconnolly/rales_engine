require 'csv'

namespace :db do

  desc "read all files in db/data directory and create records in db"
  task :load_data => :environment do
    Dir.glob("#{Rails.root}/db/data/*.csv").each do |file|
      model = File.basename(file, ".csv").singularize
      data = CSV.read(file, {headers: true})
    end
  end


  desc "read each line of merchant file and create merchant records for each row in file"
  task :load_merchants => :environment do
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/merchants.csv", {headers: true}) do |line|
      Merchant.create(line.to_hash)
      record_count += 1
      puts "Opened Merchant data file and created #{record_count} merchant records."
    end
  end

  desc "read each line of customer file and create customer records for each row in file"
  task :load_customers => :environment do
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/customers.csv", {headers: true}) do |line|
      Customer.create(line.to_hash)
      record_count += 1
    end
    puts "Opened customer data file and created #{record_count} customer records."
  end

  desc "read each line of items file and create item records for each row in file"
  task :load_items => :environment do
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/items.csv", {headers: true}) do |line|
      Item.create(line.to_hash)
      record_count += 1
    end
    puts "Opened item data file and created #{record_count} item records."
  end

  desc "read each line of transactions file and create transaction records for each row in file"
  task :load_transactions => :environment do
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/transactions.csv", {headers: true}) do |line|
      Transaction.create(line.to_hash)
      record_count += 1
    end
    puts "Opened transaction data file and created #{record_count} transaction records."
  end

  desc "read each line of invoices file and create invoice records for each row in file"
  task :load_invoices => :environment do
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/invoices.csv", {headers: true}) do |line|
      Invoice.create(line.to_hash)
      record_count += 1
    end
    puts "Opened invoice data file and created #{record_count} invoice records."
  end

  desc "read each line of invoice_items file and create invoice_item records for each row in file"
  task :load_invoice_items => :environment do
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/invoice_items.csv", {headers: true}) do |line|
      InvoiceItem.create(line.to_hash)
      record_count += 1
    end
    puts "Opened invoice_item data file and created #{record_count} invoice_item records."
  end

  #trying to refactor to get rid of repetitiveness
  task :load_ambig_file => :environment do
    load_file("merchants", Merchant)
  end

  def load_file(record_name, model)
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/#{record_name}.csv", {headers: true}) do |line|
      require "pry"; binding.pry
      model.create(line.to_hash)
      record_count += 1
    end
  end

end
