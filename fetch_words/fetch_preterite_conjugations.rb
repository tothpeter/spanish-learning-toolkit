require 'net/http'
require 'nokogiri'
require 'json'


class English
  BASE_URL = 'https://translate1.spanishdict.com/api/v1/verb'

  def self.get(infinitive_verb_en)
    query_params = {
      q:      infinitive_verb_en,
      source: :en
    }

    final_url = BASE_URL
    uri = URI.parse(final_url)
    uri.query = URI.encode_www_form(query_params)

    page_content = Net::HTTP.get(uri)
    json_content = JSON.parse(page_content)

    json_content['data']['paradigms']['preteritIndicative'].map(&:values).flatten
  end
end



pronouns_en = ['I', 'you', 'he', 'we', 'you all', 'they']
pronouns_es = ['yo', 'tú', 'él', 'nosotros', 'vosotro', 'ellos']

printf 'Infinitive verb in Español: '
infinitive_verb_es = gets.chomp

base_url = 'https://www.spanishdict.com/conjugate'

final_url = "#{base_url}/#{infinitive_verb_es}"
page_content = Net::HTTP.get(URI.parse(final_url))

document = Nokogiri::HTML(page_content)

infinitive_verb_en = document.search('#quickdef1-es').first.content

infinitive_base_verb_en = English.get(infinitive_verb_en)

require "readline"
infinitive_past_verb_en = Readline.insert_text(infinitive_base_verb_en).readline("Infinitive verb in English: ")
#
# printf 'Infinitive verb in English: ' + infinitive_base_verb_en
# answer = gets.chomp
# infinitive_past_verb_en = answer unless answer == ''

conjugation_es = document.search('.conjugation [data-tense="preteritIndicative"]').map(&:content)
conjugation_en = [infinitive_past_verb_en] * 6

conjugation_with_pron_en = pronouns_en.zip(conjugation_en).map { |a| a.join(' ') }
conjugation_with_pron_es = pronouns_es.zip(conjugation_es).map { |a| a.join(' ') }

conjugation_with_pron_en.zip(conjugation_with_pron_es).each do |conjugation_en, conjugation_es|
  puts "#{conjugation_en}\t#{conjugation_es}"
end
