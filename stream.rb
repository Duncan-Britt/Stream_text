require "sinatra"
require "sinatra/reloader" if development?
require 'sinatra/content_for'
require "tilt/erubis"
require 'sinatra/streaming'

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

get '/' do
  erb :main
end

def pause(chr)
  if chr =~ /[.?!]/
    sleep(rand(20)/10.0)
  elsif chr =~ /\s/
    sleep(rand(10)/70.0)
  else
    sleep(rand(10)/100.0)
  end
end

def print_html(chr, out)
  if chr == "\n"
    out.print '<br /><br />'
  end
end

def output_stream(array)
  idx = 0
  stream do |out|
    out.puts erb :top
    loop do
      break if idx == array.size
      out.print array[idx]
      pause(array[idx])
      print_html(array[idx], out)
      idx += 1
    end
  end
end

def clean(text)
  text = text.gsub(/(\b|)\n\b/, ' ')
  text.gsub(/\B\n\b/, "\n")
end

get '/stream' do
  text = File.read(data_path + '/text.txt')
  text = clean(text)
  characters = text.chars
  output_stream(characters)

  # p text[0..5000]
end
