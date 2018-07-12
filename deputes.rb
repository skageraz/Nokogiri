require 'nokogiri'
require 'open-uri'

@prenom = []
@nom = []
@link = []
@emails = []
def noms
  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  names=[]
  doc.xpath('//ul[@class= "col3"]//a').each do |v|
    names << v.text
  end

  names.map! { |item| item.delete_prefix("M. ") }
  names.map! { |item| item.delete_prefix("Mme ") }
  names.each { |item| array = item.split(" ")
    @prenom << array[0]
    @nom << array.drop(1).join(" ")
  }

end

def links

  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  doc.xpath('//ul[@class= "col3"]//a/@href').each do |v|
    @link<<"http://www2.assemblee-nationale.fr"+v.text
  end


  link.each do |mail|
  doc = Nokogiri::HTML(open(mail))
  doc.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[1]/a/@href').each do |node|
    puts node.text[7..-1]
    @emails << node.text[7..-1]
    end
  puts emails
  end
end

links
