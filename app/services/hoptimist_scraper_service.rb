class HoptimistScraperService

  def initialize
    browser = Capybara.current_session
    Capybara.using_wait_time(120) do
      browser.visit("https://business.untappd.com/embeds/iframes/35562/137777")
      browser.find(".tab-anchor", text: "Cans + Bottles").click
      @beer_elements = browser.all(".item")
    end
  end

  def menu
    @beer_elements.map{|element| element_to_item(element)}
  end

  private

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
      text = element.find(selector).text.strip
    rescue Capybara::ElementNotFound
      nil
    end
  end

end