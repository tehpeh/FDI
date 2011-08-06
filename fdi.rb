require 'bundler/setup'
require 'sinatra'
require 'datamapper'

class Obs
  include DataMapper::Resource
  property :id,         Serial
  property :time,       DateTime
end
DataMapper.finalize

configure :development do
  require 'sinatra/reloader'
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/fdi_development.sqlite3")
  DataMapper.auto_upgrade!
end

configure :test do
  DataMapper.setup(:default, 'sqlite::memory:')
end

get '/' do
  status 200
  obs = Obs.create(:time => Time.now)
  "oks - #{obs.time} - #{Obs.count} -yeah!"
end