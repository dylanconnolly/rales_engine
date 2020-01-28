require 'csv'

namespace :db do

  desc "read all files in db/data directory and create records in db"
  task :load_data => :environment do
    Dir.glob("#{Rails.root}/db/data/*.csv").each do |file|
      model = File.basename(file, ".csv").singularize
      data = CSV.read(file, {headers: true})
    end
  end

  desc "read each line of merchant file and create merchant objects for each record"
  task :load_merchants => :environment do
    CSV.foreach("#{Rails.root}/db/data/merchants.csv", {headers: true}) do |line|
      Merchant.create(line.to_hash)
    end
  end
end
