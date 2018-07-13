require 'nokogiri'
require 'open-uri'

def trader_obscur
      doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

      values=[]
      currencies=[]
    doc.xpath('//a[@class= "price"]/text()').each do |v| #on entre toutes les valeurs dans un tableau values
       values<<v.text
     end

    doc.xpath('//a[@class= "currency-name-container link-secondary"]').each do |v|
       currencies<<v.text    #on entre toutes les devises dans un tableau  currencies
     end



hash=currencies.zip(values).to_h #on combine les deux tableaux dans un hash 

puts hash
end

every trader_obscur
