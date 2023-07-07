class HoptimistScraperService

  def initialize(params)
    @response = URI.open("https://business.untappd.com/locations/35562/themes/137777/js")
    stripped_text = File.read(@response).split("container.innerHTML = \"  ")[1].split("function(")[0].strip.gsub("\\n","").gsub("\\\\", "").gsub("\\\\\\\\", "").gsub("\\", "")
    noko = Nokogiri::HTML(stripped_text)
    @beer_elements = noko.css("#menu-114294")[0].css(".item-details")
    @params = params
  end

  def menu
    {cans: filter_beers(@beer_elements.map{|element| element_to_item(element)})}
  end

  private

  def filter_beers(beers)
    beers.filter{|item| item[:beer_type].downcase.include?(beer_type.downcase)}
  end

  def beer_type
    @params["beer_type"] || ""
  end

  def element_to_item(element)
    {
      name: get_raw_text_from_selector(element, ".item-name > a"),
      beer_type: get_raw_text_from_selector(element, ".item-style > .item-style"),
      abv: get_raw_text_from_selector(element, ".item-abv"),
      brewery: get_raw_text_from_selector(element, ".brewery"),
      ibu: nil
    }
  end

  def get_raw_text_from_selector(element, selector)
    begin
      text = element.css(selector).first.inner_text.strip
    rescue NoMethodError
      nil
    end
  end

end