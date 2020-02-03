# Rales Engine

## Background and Description

Backend Module 3 Week 1 Solo Project

Rales Engine is a project completed by myself during the first week of Module 3 at Turing School of Software and Design. This project consumes sales related data from CSV files through a rake task and creates records for each resource type in the database. Once this has been completed, Rales Engine allows for requests to be made to endpoints ranging from specific record endpoints to business intelligence endpoints which will return sales related insights on some or all of the data.

## Getting Started

1. Clone this repository.

```
git clone git@github.com:LainMcGrath/monster_shop_part_1.git
```
2. Navigate into directory and bundle install:

```
cd rales_engine/
bundle install
```
3. Run rake task to import all of the records in the data file:

```
rake db:load_all_data
```
Alternatively, each data file can be loaded manually by running `rake db:load_[resource_name]`:
```
rake db:load_customers
rake db:load_invoiceitems
rake db:load_invoices
rake db:load_invoices
rake db:load_items
rake db:load_merchants
rake db:load_transactions
```
4. To run RSpec test suite:

```
bundle exec rspec
```


Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
