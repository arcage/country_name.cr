require "http/client"
require "uri"
require "yaml"

module CountryName
  class Error < Exception; end

  VERSION = "0.1.0"

  CACHE_DIR = File.expand_path(File.dirname(File.dirname(__FILE__))) + "/cache"

  SUPPORTED_LANG = ["af", "ak", "am", "ar", "as", "az", "be", "bg", "bm", "bn", "bo", "br", "bs", "ca", "ce", "cs", "cy", "da", "de", "dz", "ee", "el", "en", "eo", "es", "et", "eu", "fa", "ff", "fi", "fo", "fr", "fy", "ga", "gd", "gl", "gu", "gv", "ha", "he", "hi", "hr", "hu", "hy", "ia", "id", "ig", "ii", "is", "it", "ja", "jv", "ka", "ki", "kk", "kl", "km", "kn", "ko", "ks", "ku", "kw", "ky", "lb", "lg", "ln", "lo", "lt", "lu", "lv", "mg", "mi", "mk", "ml", "mn", "mr", "ms", "mt", "my", "nb", "nd", "ne", "nl", "nn", "no", "om", "or", "os", "pa", "pl", "ps", "pt", "qu", "rm", "rn", "ro", "ru", "rw", "sd", "se", "sg", "sh", "si", "sk", "sl", "sn", "so", "sq", "sr", "sv", "sw", "ta", "te", "tg", "th", "ti", "tk", "tl", "to", "tr", "tt", "ug", "uk", "ur", "uz", "vi", "wo", "xh", "yi", "yo", "zh", "zu"]

  def self.update_cache : Bool
    Dir.mkdir_p(CACHE_DIR) unless File.directory?(CACHE_DIR)
    modified = false
    CountryName::SUPPORTED_LANG.each do |lang|
      uri = URI.parse("https://raw.githubusercontent.com/umpirsky/country-list/master/data/#{lang}/country.yaml")
      cache_file = CACHE_DIR + "/#{lang}.yaml"
      mtime = File.exists?(cache_file) ? File.info(cache_file).modification_time : Time.new(2000, 1, 1)
      http = HTTP::Client.new(uri)
      headers = HTTP::Headers.new
      headers["If-modified-since"] = HTTP.format_time(mtime)
      responce = http.get(uri.path.not_nil!, headers)
      case responce.status_code
      when 200
        STDERR << "[CountryName] Country code table(#{lang}) is updated.\n"
        File.write(cache_file, responce.body)
        modified = true
      when 304
        STDERR << "[CountryName] Country code table(#{lang}) is not modified.\n"
      when 404
        STDERR << "[CountryName] Country code table(#{lang}) is not found.\n"
      else
        STDERR << "[CountryName] Receive status code #{responce.status_code} for country code table(#{lang}).\n"
      end
    end
    return modified
  end

  @@table = Hash(String, Hash(String, String)).new do |h, k|
    h[k] = Hash(String, String).new
  end

  class_getter default_lang = "en"

  def self.init
    update_cache if Dir[CACHE_DIR + "/*.yaml"].empty?
    @@table.clear
    Dir.glob(CACHE_DIR + "/*.yaml").each do |file|
      lang = File.basename(file, ".yaml")
      data = YAML.parse(File.read(file)).as_h
      data.each do |cc, name|
        @@table[cc.as_s.downcase][lang] = name.as_s
      end
    end
  end

  def self.default_lang=(lang : String)
    d_lang = lang.downcase
    if File.exists?(CACHE_DIR + "/#{d_lang}.yaml")
      @@default_lang = d_lang
    else
      raise Error.new("Unsupported language(#{lang})")
    end
  end

  def self.from_country_code?(cc : String, lang : String? = nil) : String?
    init if @@table.empty?
    lang ||= @@default_lang
    cc = cc.downcase
    @@table.has_key?(cc) ? @@table[cc][lang.downcase] : nil
  end

  def self.from_country_code(cc : String, lang : String? = nil) : String
    from_country_code?(cc, lang) || raise Error.new("Country code \"#{cc}\" not found.")
  end
end
