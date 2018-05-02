# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Category.create!({title: 'Ruby', description: 'Ruby Description'})
Category.create!({title: 'PHP', description: 'PHP Description'})
Category.create!({title: 'HTML', description: 'HTML Description'})
Category.create!({title: 'JavaScript', description: 'JavaScript Description'})
Category.create!({title: 'CSharp', description: 'CSharp Description'})
Category.create!({title: 'Visual Basic', description: 'Visual Basic Description'})
Category.create!({title: 'SQL', description: 'SQL Description'})
Category.create!({title: 'MySQL', description: 'MySQL Description'})
Category.create!({title: 'Mongo', description: 'Mongo Description'})
Category.create!({title: 'Node', description: 'Node Description'})

Category.all.each do |cat|
	params = {
      "Service" => "AWSECommerceService",
      "Operation" => "ItemSearch",
      "AWSAccessKeyId" => "AKIAJWPWTVNYFLW7EKHQ",
      "AssociateTag" => "phuongvyshop-20",
      #"SearchIndex" => "All",
      "SearchIndex" => "Books",
      "Keywords" => cat.title,
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
    json = Hash.from_xml(xml)

    json["ItemSearchResponse"]["Items"]["Item"].each { |i|
      p = Product.new
      p.item_code = i["ASIN"]
      p.picture = i["LargeImage"]["URL"]
      p.title = i["ItemAttributes"]["Title"]
      p.description = i["ItemAttributes"]["Title"] + ' description'
      p.price = 299.99
      p.price = i["ItemAttributes"]["ListPrice"]["Amount"].to_f if i["ItemAttributes"].key?('ListPrice')
      p.category_id = cat.id
      p.save
    }
end