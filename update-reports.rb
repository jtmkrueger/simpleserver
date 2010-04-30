#!/usr/bin/ruby
require 'rubygems'
require 'mysql'
 
db = Mysql::new("localhost","root","","simpleserver")
up = db.query("UPDATE reports SET fixed = 1 WHERE fixed = 0")
 
puts "Reports marked as fixed, resuming normal monitoring."