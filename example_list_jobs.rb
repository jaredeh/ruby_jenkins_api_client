#https://github.com/arangamani/jenkins_api_client
require 'jenkins_api_client'
require 'optparse'

options = {}
opt = OptionParser.new do |opt|
  opt.on('--server_url URL') { |o| options[:server_url] = o }
  opt.on('--server_port PORT') { |o| options[:server_port] = o }
  opt.on('--server_ip IPADDRESS') { |o| options[:server_ip] = o }
  opt.on('--username LASTNAME') { |o| options[:username] = o }
  opt.on('--password LASTNAME') { |o| options[:password] = o }
end

opt.parse!

if not ( options[:server_url] or options[:server_ip] )
  puts opt.help
  puts ""
  puts "Must select --server_url or --server_ip"
  exit 1
end
puts options

@client = JenkinsApi::Client.new(options)

puts @client.job.list_all

