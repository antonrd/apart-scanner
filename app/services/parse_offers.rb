require 'open-uri'
require 'uri'

class ParseOffers
  PAGED_URL = "http://www.imot.bg/pcgi/imot.cgi?act=3&slink=24h7g8&f1="
  URL_SUFFIX = ""
  PAGE_REGEX = /Страница (\d+) от (\d+)/

  # PAGED_URL = "imot.bg."
  # URL_SUFFIX = ".html"
  MAIN_PAGE_URL = "#{ PAGED_URL }1#{ URL_SUFFIX }"

  OFFERS_PER_PAGE = 40

  def initialize(scan_url)
    @scan_url = scan_url
    @all_offers = 0
    @new_offers = 0
  end

  def main_page_url
    paged_url 1
  end

  def paged_url page_number
    if @scan_url.present?
      "#{ @scan_url.url }#{ page_number }#{ @scan_url.url_suffix }"
    else
      "#{ PAGED_URL }#{ page_number }#{ URL_SUFFIX }"
    end
  end

  def valid_offer?(offer)
    !offer.css('a').empty?
  end

  def has_next_page?(page)
    !page.css('a.pageNumbers').map(&:text).select { |value| value == 'Напред' }.empty?
  end

  def process_page page_number, f
    page = Nokogiri::HTML(open(paged_url(page_number)))
    # page = Nokogiri::HTML(open("imot_bg_test.html"))

    File.open("imot.bg.#{ page_number }.html", "w") do |f|
      f.write(page.to_s)
    end

    tables = page.css('table')

    puts "tables: #{tables.count}"

    counter = 1

    start_index = 12
    end_index = start_index + (OFFERS_PER_PAGE - 1) * 3
    (start_index..end_index).step(3).each do |table_index|
      # puts "======================= OFFER ========================="
      offer_html = tables[table_index]
      # puts table_index
      puts counter

      counter += 1

      unless valid_offer?(offer_html)
        puts "This page contains less than #{ OFFERS_PER_PAGE } offers"
        break
      end

      link = offer_html.css('a')[0]['href']

      offer_hash = URI(link).query.split('&').map { |param| param.split('=') }.select{ |key, value| key == 'adv' }.first.last.strip

      puts offer_hash

      offer = Offer.find_by(offer_hash: offer_hash)
      unless offer
        offer = Offer.create(offer_hash: offer_hash, first_scan: @scan)
        @new_offers += 1
      end
      # offer = Offer.find_or_create_by(offer_hash: offer_hash)
      @all_offers += 1
      # @new_offers += 1 if offer.offer_versions.empty?

      raw_offer_html = offer_html.to_s.encode('utf-8').gsub(/\.\.\/images/, 'http://www.imot.bg/images')
      offer.offer_versions.create(html_content: raw_offer_html, scan: @scan)
    end

    has_next_page?(page)
  end

  def call
    page = Nokogiri::HTML(open(main_page_url))

    # max_page = page.css('a.pageNumbers').map(&:text).select { |value| /\d+/.match(value) }.map(&:to_i).max
    max_page = PAGE_REGEX.match(page.css('span.pageNumbersInfo').first.text)[2].to_i

    puts "Found #{ max_page } pages."

    @scan = Scan.create(pages: max_page, scan_url: @scan_url)

    File.open('offers.html', 'w') do |f|
      more_pages_exist = true
      (1..max_page).each do |page_number|
        puts "Processing page #{ page_number }..."

        f.write("<div style=\"font-size: 20px;\"> Page: #{ page_number }</div>")
        more_pages_exist = process_page(page_number, f)
      end
    end

    @scan.update_attributes(all_offers: @all_offers, new_offers: @new_offers)

    @scan
  end
end
