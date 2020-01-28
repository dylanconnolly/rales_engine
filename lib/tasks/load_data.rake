require 'csv'

namespace :db do

  task :load_all_data => :environment do
    data_file_models = [Customer, Merchant, Item, Invoice, Transaction, InvoiceItem]
    data_file_models.each do |data|
      load_file(data)
    end
  end


##### Old load data rake tasks

  desc "read each line of merchant file and create merchant records for each row in file"
  task :load_merchants => :environment do
    Merchant.destroy_all
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/merchants.csv", {headers: true}) do |line|
      Merchant.create(line.to_hash)
      record_count += 1
    end
    puts "Opened Merchant data file and created #{record_count} merchant records."
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

  def load_file(model)
    model.delete_all
    record_name = model.to_s.downcase.pluralize
    record_count = 0
    CSV.foreach("#{Rails.root}/db/data/#{record_name}.csv", {headers: true}) do |line|
      model.create(line.to_hash)
      record_count += 1
    end
    puts "Created #{record_count} #{model.to_s} records."
  end

end
