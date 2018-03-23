class HomeController < ApplicationController
  def index
    # res = Amazon::Ecs.item_search('com', {:response_group => 'Medium', :sort => 'salesrank'})
    # @results = res.items
    # rs = []
    #
    # item_price = ''
    # res.items.each do |item|
    #
    #   product = {}
    #   product[:title] = item.get('ItemAttributes/Title')
    #   product[:picture] = item.get_hash('LargeImage')['URL']
    #   product[:item_code] = item.get('ASIN')
    #   item_price = Amazon::Ecs.item_search({"Service" => 'AWSECommerceService', "ResponseGroup" => 'Offers', "Operation" => 'ItemLookup', "IdType" => 'ASIN', "ItemId" =>item.get('ASIN') })
    #   # rs_price = item_price->get_hash('Amount')
    #
    #   rs.push(product)
    # end
    # #ap item_price
    # item_price = item_price.first_item
    # ap item_price.get_hash()
    # puts 'zzzz'
    # ap rs
  end

  def product_info
    # link document: http://webservices.amazon.com/scratchpad/index.html#http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemLookup&SubscriptionId=AKIAJWPWTVNYFLW7EKHQ&AssociateTag=phuongvyshop-20&ItemId=0062457713&IdType=ASIN&ResponseGroup=ItemIds,Offers,OfferSummary
    list_product_group = ["Appliances", "ArtsAndCrafts", "MobileApps", "HealthPersonalCare", "Grocery", "GiftCards", "FashionWomen", "FashionMen", "FashionGirlss", "FashionBoys", "Beauty"]
    list_result = []
    product_item = nil
    product_obj = Product.new
    list_product_group.each do |value|
      params = {
        "Service" => "AWSECommerceService",
        "Operation" => "ItemSearch",
        "AWSAccessKeyId" => "AKIAJWPWTVNYFLW7EKHQ",
        "AssociateTag" => "phuongvyshop-20",
        "SearchIndex" => value,
        "Keywords" => "app",
        "ResponseGroup" => "Accessories,ItemAttributes,Large,Offers,OfferSummary"
      }

      # Set current timestamp if not set
      params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")

      # Generate the canonical query
      canonical_query_string = params.sort.collect do |key, value|
        [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
      end.join('&')

      # Generate the string to be signed
      string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"

      # Generate the signature required by the Product Advertising API
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), SECRET_KEY, string_to_sign)).strip()

      # Generate the signed URL
      request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"

      #puts "Signed URL: \"#{request_url}\""
      xml = Net::HTTP.get(URI.parse(request_url))

      product = Hash.from_xml(xml)
      product_item = product

      list_result.push(product)
      #ap doc
      #render json: product
    end
    #ap list_result
    #ap product_item
    product_obj = nil
    product_item["ItemSearchResponse"]["Items"]["Item"].each do |item|
      product_obj = item
    end
    render json: product_obj
    # product_obj["ASIN"]
    # product_obj["LargeImage"]["URL"]
    # product_obj["ImageSets"]["ImageSet"]
    #render json: product_item["ItemSearchResponse"]["Items"]["Item"]
  end

  def products
    # link document: http://webservices.amazon.com/scratchpad/index.html#http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemLookup&SubscriptionId=AKIAJWPWTVNYFLW7EKHQ&AssociateTag=phuongvyshop-20&ItemId=0062457713&IdType=ASIN&ResponseGroup=ItemIds,Offers,OfferSummary
    list_product_group = ["Appliances", "ArtsAndCrafts", "MobileApps", "HealthPersonalCare", "Grocery", "GiftCards", "FashionWomen", "FashionMen", "FashionGirlss", "FashionBoys", "Beauty"]
    list_result = []
    product_item = nil
    product_obj = Product.new
    list_product_group.each do |value|
      params = {
        "Service" => "AWSECommerceService",
        "Operation" => "ItemSearch",
        "AWSAccessKeyId" => "AKIAJWPWTVNYFLW7EKHQ",
        "AssociateTag" => "phuongvyshop-20",
        "SearchIndex" => value,
        "Keywords" => "app",
        "ResponseGroup" => "Accessories,ItemAttributes,Large,Offers,OfferSummary"
      }

      # Set current timestamp if not set
      params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")

      # Generate the canonical query
      canonical_query_string = params.sort.collect do |key, value|
        [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
      end.join('&')

      # Generate the string to be signed
      string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"

      # Generate the signature required by the Product Advertising API
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), SECRET_KEY, string_to_sign)).strip()

      # Generate the signed URL
      request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"

      #puts "Signed URL: \"#{request_url}\""
      xml = Net::HTTP.get(URI.parse(request_url))

      product = Hash.from_xml(xml)
      product_item = product

      list_result.push(product)
      #ap doc
      #render json: product
    end
    #ap list_result
    #ap product_item
    product_obj = nil
    product_result = []
    product_item["ItemSearchResponse"]["Items"]["Item"].each do |item|
      p = Product.new
      p["item_id"] = item["ASIN"]
      p["item_code"] = item["ASIN"]
      p["picture"] = item["LargeImage"]["URL"]
      list_img = []
      #if item["ImageSets"]["ImageSet"].blank?
        item["ImageSets"]["ImageSet"].each do |img|
          list_img.push(img["LargeImage"]["URL"])
        end
      #end
      p["galleries"] = list_img.join(",")
      p["price"] = item["ItemAttributes"]["ListPrice"]["Amount"]
      p["price_sale"] = item["ItemAttributes"]["ListPrice"]["Amount"]
      p["title"] = item["ItemAttributes"]["Title"]
      product_obj = p
    end
    render json: product_obj
    # product_obj["ASIN"]
    # product_obj["LargeImage"]["URL"]
    # product_obj["ImageSets"]["ImageSet"]
    #render json: product_item["ItemSearchResponse"]["Items"]["Item"]
  end
end
