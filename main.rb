REPO_URL = "https://github.com/Flaptus/Flaptus"

require "sinatra"
require "nokogiri"
require "open-uri"

set :bind, "0.0.0.0"

$versions = {}
Thread.new do
	loop do
		page = 1
		loop do
			count = 0
			Nokogiri::HTML.parse(URI.open("#{REPO_URL}/releases?page=#{page}")).xpath("//a").each do |tag|
				if tag[:href].split("/")[-1] == "flaptus.exe"
					$versions[tag[:href].split("/v")[1].split("/")[0]] = "https://github.com/#{tag[:href]}"
					count += 1
				end
			end
			break if count == 0
			page += 1
		end

		sleep 600
	end
end

get "/" do
	erb :index
end