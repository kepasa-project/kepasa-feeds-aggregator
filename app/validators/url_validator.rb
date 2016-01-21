class UrlValidator < ActiveModel::EachValidator
 # ho preso questa validazione da una pagina https://coderwall.com/p/ztig5g/validate-urls-in-rails per validare le URL dei feed
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)    
  end

  # a URL may be technically well-formed but may 
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end 
end