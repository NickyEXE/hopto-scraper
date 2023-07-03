class UntappdScraperService

  def initialize
    @response = Nokogiri::HTML(URI.open("https://untappd.com/v/the-hoptimist/10581626"))
    @menu_html = @response.css("#section-menu-list-624130").first.css(".beer-details")
    @on_deck_html = @response.css("#section-menu-list-624132").first.css(".beer-details")
  end

  def full_menu
    {menu:, on_deck_menu:}
  end

  def menu
    get_menu(@menu_html)
  end

  def on_deck_menu
    get_menu(@on_deck_html)
  end

  private

  def get_menu(html)
    html.map{|beer_detail_element| element_to_item(beer_detail_element)}
  end

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