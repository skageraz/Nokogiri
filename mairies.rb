require 'nokogiri'
require 'open-uri'

@link_mairies =[]

def email_of_a_townhal_from_its_webpage
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/vaureal.html'))
  doc.xpath('//*[contains(text(), "@" )]').each do |node|
    puts node.text
  end
end

def all_the_urls_of_val_doise_townhalls
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

  web = 'http://annuaire-des-mairies.com'
  doc.xpath('//p/a[@class = "lientxt"]/@href').each do |node|
    @link_mairies << node.text
  end
  @link_mairies.map! { |item| web + item[1..-1] }
  puts @link_mairies
end

def all_the_mails_of_val_doise_townhalls
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

  web = 'http://annuaire-des-mairies.com'
  doc.xpath('//p/a[@class = "lientxt"]/@href').each do |node|
    @link_mairies << node.text
  end
  @link_mairies.map! { |item| web + item[1..-1] }
  @mail_mairies = []
  @link_mairies.each do |mail|
  doc = Nokogiri::HTML(open(mail))
    doc.xpath('//*[contains(text(), "@" )]').each do |v|
      @mail_mairies<< v.text
  end
  puts @mail_mairies
 end

end

all_the_urls_of_val_doise_townhalls
all_the_mails_of_val_doise_townhalls

#the_email_of_a_townhal_from_its_webpage
