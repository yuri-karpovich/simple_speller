require 'simple_speller/version'
require 'httparty'
require 'json'

module SimpleSpeller
  SERVICE_URL = 'https://speller.yandex.net/services/spellservice.json/checkText?text='.freeze

  def self.check(text, options = {})
    response = HTTParty.post(SERVICE_URL + CGI.escape(text),
                             body:    { lang:    options[:lang] || 'ru,en',
                                        format:  'pain',
                                        options: 518 }.to_json,
                             headers: { 'Content-Type' => 'application/json' })
    JSON.parse response.body
  end

  def self.fix(text, options = {})
    t = text.dup
    check(text, options).each do |ehash|
      start_i           = ehash['pos']
      end_i             = start_i + ehash['len'] - 1
      t[start_i..end_i] = ehash['s'].first
    end
    t
  end
end