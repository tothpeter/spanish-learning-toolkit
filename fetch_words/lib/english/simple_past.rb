module English
end

class English::SimplePast
  BASE_URL = 'https://translate1.spanishdict.com/api/v1/verb'

  def self.fetch(infinitive_verb_en)
    query_params = {
      q:      infinitive_verb_en,
      source: :en
    }

    uri = URI.parse(BASE_URL)
    uri.query = URI.encode_www_form(query_params)

    page_content = Net::HTTP.get(uri)
    json_content = JSON.parse(page_content)

    json_content['data']['paradigms']['preteritIndicative'].first.values.last.split.last
  end
end
