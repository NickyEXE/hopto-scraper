class UntappdScraperService

  def initialize
    @response = Nokogiri::HTML(URI.open("https://untappd.com/v/the-hoptimist/10581626"))
    @menu_html = @response.css("#section-menu-list-624130").first.css(".beer-details")
  end

  def menu
    @menu_html.map{|beer_detail_element| element_to_item(beer_detail_element)}
  end

  private

  def element_to_item(beer_detail_element)
    abv, ibu, brewery = get_raw_text_from_selector(beer_detail_element, "h6 > span").split("•").map(&:strip!)
    {
      name: get_raw_text_from_selector(beer_detail_element, "h5 > a"),
      beer_type: get_raw_text_from_selector(beer_detail_element, "h5 > em"),
      abv:, ibu:, brewery:
    }
  end

  def get_raw_text_from_selector(element, selector)
    element.css(selector).first.inner_text.strip
  end

end