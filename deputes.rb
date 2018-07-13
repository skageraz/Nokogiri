require 'nokogiri'
require 'open-uri'


@link = []
@emails = []
@nom = []
@prenom = []

def noms

  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  names=[] #Création d'un tableau intermediaire pour stocker des valeurs brutes
  doc.xpath('//ul[@class= "col3"]//a').each do |v| #on boucle pour extraire et mettre les noms dans un tableau
    names<<v.text
  end

  names.map! { |item| item.delete_prefix("M. ") } #supression des préfixes
  names.map! { |item| item.delete_prefix("Mme ") }
  names.each { |item| array = item.split(" ")   #on sépare le string "prenom nom" au niveau de l'espace
    @prenom << array[0] #on push le prenom dans un array
    @nom << array.drop(1).join(" ") #on push le reste dans un autre array en séparant du prenom avec drop et en recollant l'espace avec join
  }
  puts @prenom
  puts @nom

end

def links

# on scrape les liens vers les fiches députés
  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  doc.xpath('//ul[@class= "col3"]//a/@href').each do |v|
    @link<<"http://www2.assemblee-nationale.fr"+v.text  #on stocke dans un array link
  end

  @link.each do |mail| #pour chaque iteration on va chercher l'adresse mail
  doc = Nokogiri::HTML(open(mail))
  doc.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[1]/a/@href').each do |node|

    @emails << node.text[7..-1] #on vire le mail:to
    end
  puts @emails
  end


noms
links
