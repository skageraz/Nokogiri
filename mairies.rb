require 'nokogiri'
require 'open-uri'

@link_mairies =[]

def email_of_a_townhal_from_its_webpage
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/vaureal.html'))
  doc.xpath('//*[contains(text(), "@" )]').each do |node| #on scanne les elements de la page qui contienne le caractère @
    puts node.text
  end
end

def all_the_urls_of_val_doise_townhalls
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

  web = 'http://annuaire-des-mairies.com'
  doc.xpath('//p/a[@class = "lientxt"]/@href').each do |node| #on récupère les éléments et on les mets dans un tableau
    @link_mairies << node.text
  end
  @link_mairies.map! { |item| web + item[1..-1] } #on rajoute dans chaque élément du tableau l'adresse http complete
  puts @link_mairies
end

def all_the_mails_of_val_doise_townhalls
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

  web = 'http://annuaire-des-mairies.com' #reprise de la fonction des urls
  doc.xpath('//p/a[@class = "lientxt"]/@href').each do |node|
    @link_mairies << node.text
  end
  @link_mairies.map! { |item| web + item[1..-1] }
  @mail_mairies = []
  @link_mairies.each do |mail| #Pour chacune des urls on va chercher l'adresse mail pour chaque mairie du val d'oise
  doc = Nokogiri::HTML(open(mail))
    doc.xpath('//*[contains(text(), "@" )]').each do |v|
      @mail_mairies<< v.text #que l'on met dans un tableau "@mail_mairies"
  end
   puts @mail_mairies
 end

end

def magic_hash #on réunit le tout dans un hash
  city_names=[]
  doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
  doc.xpath('//p/a[@class = "lientxt"]/text()').each do |node|
    city_names << node.text #on récupere les noms de chaque mairie 
end
    all_the_mails_of_val_doise_townhalls

  x = 0
  city_hash={}
while x < ( city_names.size )
 city_hash = { 'name' => city_names[x], 'email' => @mail_mairies[x] }
 puts city_hash
 x += 1
end

end
email_of_a_townhal_from_its_webpage
#all_the_urls_of_val_doise_townhalls
magic_hash

#all_the_mails_of_val_doise_townhalls
