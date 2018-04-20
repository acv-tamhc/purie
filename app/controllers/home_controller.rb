class HomeController < ApplicationController
  def index
    # link document: http://webservices.amazon.com/scratchpad/index.html#http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemLookup&SubscriptionId=AKIAJWPWTVNYFLW7EKHQ&AssociateTag=phuongvyshop-20&ItemId=0062457713&IdType=ASIN&ResponseGroup=ItemIds,Offers,OfferSummary
    params = {
      "Service" => "AWSECommerceService",
      "Operation" => "ItemSearch",
      "AWSAccessKeyId" => "AKIAJWPWTVNYFLW7EKHQ",
      "AssociateTag" => "phuongvyshop-20",
      "SearchIndex" => "All",
      "Keywords" => "a",
      "ResponseGroup" => "Images,ItemAttributes,Offers"
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

    puts xml


  end
end
