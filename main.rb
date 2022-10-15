$REPO_URL = "Flaptus/Flaptus"
$ZIPS = ["v1.1.0", "v1.0.0", "v0.1-aplha"]

require "json"
require "sinatra"
require "open-uri"

set :bind, "0.0.0.0"

$versions = []
    
Thread.new do
	loop do
		$versions = JSON.load(URI.open("https://api.github.com/repos/#{$REPO_URL}/tags").read).map { |tag| tag["name"] }

		sleep 600

        `rm open-uri*`
	end
end

get "/" do
	erb :index
end