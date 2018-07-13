require 'nokogiri'
require 'open-uri'

def trader_obscur
      doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

      values=[]
      currencies=[]
    doc.xpath('//a[@class= "price"]/text()').each do |v|
       values<<v.text
     end

    doc.xpath('//a[@class= "currency-name-container link-secondary"]').each do |v|
       currencies<<v.text
     end



hash=currencies.zip(values).to_h

puts hash
end

trader_obscur
