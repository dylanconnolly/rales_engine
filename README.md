# Rales Engine


## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
* [Usage](#usage)

<!-- ABOUT THE PROJECT -->
## About the Project

Backend Module 3 Week 1 Solo Project

Rales Engine is a solo project completed during the first week of Module 3 at Turing School of Software and Design. This project focuses on building API endpoints to expose sales data that was provided in CSV files. Rales Engine consumes the sales data from the CSV files through a rake task and creates records for each resource type in the database. Once this has been completed, requests can be made to endpoints ranging from specific record endpoints to business intelligence endpoints which will return sales related insights on some or all of the data.

### Built With

* Rails (API only)
* Ruby
* FastJSON API

### Tested With
* RSpec

<!-- GETTING STARTED -->
## Getting Started

Ruby Version: 2.5.1

Rails Version: 5.2.4

1. Clone this repository.

```
git@github.com:dylanconnolly/rales_engine.git
```
2. Navigate into directory and bundle install:

```
cd rales_engine/
bundle install
```
3. Set up your database:
```
rake db:create
rake db:migrate
```
4. Run rake task to import all of the records in the data file:

```
rake db:load_all_data
```
Alternatively, each data file can be loaded manually by running `rake db:load_[resource_name]`:
```
rake db:load_customers
rake db:load_invoiceitems
rake db:load_invoices
rake db:load_items
rake db:load_merchants
rake db:load_transactions
```
5. To run RSpec test suite:

```
bundle exec rspec
```
## Usage

### Customer Endpoints
* `GET /api/v1/customers` - returns index of all customers
* `GET /api/v1/customers/:id` - returns specific customer record
* `GET /api/v1/customers/random` - returns random customer record
* `GET /api/v1/customers/:id/invoices` - returns a collection of invoices associated with that customer
* `GET /api/v1/customers/:id/transactions` - returns a collection of transactions associated with that customer
* `GET /api/v1/customers/:id/favorite_merchant` - returns the merchant where the given customer has conducted the most successful transactions.

### Invoice Item Endpoints
* `GET /api/v1/invoice_items` - returns index of all invoice items
* `GET /api/v1/invoice_items/:id` - returns specific invoice item record
* `GET /api/v1/invoice_items/random` - returns random invoice item record
* `GET /api/v1/invoice_items/:id/invoice` - returns the invoice associated with that invoice item
* `GET /api/v1/invoice_items/:id/item` - returns the item associated with that invoice item

### Invoice Endpoints
* `GET /api/v1/invoices` - returns index of all invoice
* `GET /api/v1/invoices/:id` - returns specific invoice record
* `GET /api/v1/invoices/random` - returns random invoice record
* `GET /api/v1/invoices/:id/transactions` - returns a collection of transactions associated with that invoice
* `GET /api/v1/invoices/:id/invoice_items` - returns a collection of invoice_items associated with that invoice
* `GET /api/v1/invoices/:id/items` - returns a collection of items associated with that invoice
* `GET /api/v1/invoices/:id/customer` - returns the customer associated with that invoice
* `GET /api/v1/invoices/:id/merchant` - returns the merchant associated with that invoice

### Item Endpoints
* `GET /api/v1/items` - returns index of all items
* `GET /api/v1/items/:id` - returns specific item record
* `GET /api/v1/items/random` - returns random item record
* `GET /api/v1/items/:id/invoice_items` - returns a collection of invoice_items associated with that item
* `GET /api/v1/items/:id/merchant` - returns the merchant associated with that item
* `GET /api/v1/items/most_revenue?quantity=x` - returns the top `x` items ranked by total revenue generated
* `GET /api/v1/items/:id/best_day` - returns the date with the most sales for the given item. If there are multiple days with equal number of sales, the most recent date will be returned.

### Merchant Endpoints
* `GET /api/v1/merchants` - returns index of all merchants
* `GET /api/v1/merchants/:id` - returns specific merchant record
* `GET /api/v1/merchants/random` - returns random item record
* `GET /api/v1/merchants/:id/items` - returns a collection of items associated with that merchant
* `GET /api/v1/merchants/:id/invoices` - returns a collection invoices associated with that merchant
* `GET /api/v1/merchants/most_revenue?quantity=x` - returns the top `x` merchants ranked by total revenue
`GET /api/v1/merchants/revenue?date=x` - returns the total revenue for date `x` across all merchants
`GET /api/v1/merchants/:id/favorite_customer` - returns the customer who has conducted the most successful transactions with that merchant.

### Transaction Endpoints
* `GET /api/v1/transactions` - returns index of all transactions
* `GET /api/v1/transactions/:id` - returns specific transaction record
* `GET /api/v1/transactions/random` - returns random transaction record
* `GET /api/v1/transactions/:id/invoice` - returns the invoice associated with that transaction

### Finder Endpoints
In addition to the standard routes above, you can use finder endpoints to return a single object or all of the objects that match your query parameter. For each resource, any of their attributes can be used as a search parameter. Search parameters are case insensitive.

For example:

* `GET /api/v1/items/find?parameters` - returns first instance of resource matching parameters
* `GET /api/v1/items/find_all?parameters` - returns all instances of resource matching parameters

Parameter | Description
--- | ---
id | search based on the primary key
name | search based on the name attribute
description | search based on the description attribute
unit_price | search based on the unit_price attribute (e.g. 24.98)
merchant_id | search based on the merchant_id foreign key
created_at | search based on created_at timestamp
updated_at | search based on updated_at timestamp
