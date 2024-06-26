require 'csv'

desc "loads csv's to seed the db"
namespace :csv_load do
	desc "load all csv's in the /db/data"
	task :all  do
		
	end
	desc "load all customers from /db/data/customers.csv"
	task customers: [:environment] do
		parse = CSV.parse(File.read("db/data/customers.csv"), headers: true)
		parse.each do |cust|
			c = Customer.create!(first_name: cust['first_name'],
											last_name: cust['last_name'],
											created_at: cust['created_at'],
											updated_at: cust['updated_at'])
		end
	end
end