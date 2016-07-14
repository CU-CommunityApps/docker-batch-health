#!/usr/bin/ruby

require 'rubygems'
require 'aws-sdk'
require 'aws-sdk-v1'
require 'json'

unless ENV['batch_env']
  puts "The environment variable batch_env has to be set"
  exit 1
end

db =AWS::DynamoDB.new
config_table = db.tables['batch_jobs'].load_schema
node = config_table.items["#{ENV['batch_env']}"]

loop do
	if (File.exist?('/infra/work/staging/sys/batchContainer/stepRunByBatchStepRunner~batchContainerStep.runlock'))
		node.attributes.update do |u|
              		u.set(:status => "up")
		end
	else
		node.attributes.update do |u|
              		u.set(:status => "down")
		end
	end
        sleep(15)
end
