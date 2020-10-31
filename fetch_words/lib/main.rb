require 'readline'

class Main
  PRONOUNS_EN = ['I', 'you', 'he', 'we', 'you all', 'they']
  PRONOUNS_ES = ['yo', 'tú', 'él', 'nosotros', 'vosotros', 'ellos']

  attr_reader :infinitive_verb_es

  def self.start(infinitive_verb_es)
    new(infinitive_verb_es)
  end

  def initialize(infinitive_verb_es)
    set_infinitive_verb_es(infinitive_verb_es)

    infinitive_base_verb_en = all_data['verbTranslations']['pastParticiple']

    infinitive_past_verb_en = read_from_console('The simple past in English: ', infinitive_base_verb_en || '')

    conjugation_es = all_data['verb']['paradigms']['preteritIndicative'].map{|a| a['word']}
    conjugation_en = [infinitive_past_verb_en] * 6

    conjugation_with_pron_en = PRONOUNS_EN.zip(conjugation_en).map { |a| a.join(' ') }
    conjugation_with_pron_es = PRONOUNS_ES.zip(conjugation_es).map { |a| a.join(' ') }

    conjugation_with_pron_en.zip(conjugation_with_pron_es).each do |conjugation_en, conjugation_es|
      puts "#{conjugation_en}\t#{conjugation_es}"
    end
  end

  private

  def set_infinitive_verb_es(infinitive_verb_es)
    if infinitive_verb_es.nil?
      printf 'Infinitive verb in Español: '
      @infinitive_verb_es = gets.chomp
    else
      puts 'Infinitive verb in Español: ' + infinitive_verb_es
      @infinitive_verb_es = infinitive_verb_es
    end
  end

  def all_data
    @all_data ||= fetch_all_data
  end

  def fetch_all_data
    base_url = 'https://www.spanishdict.com/conjugate'

    final_url = "#{base_url}/#{infinitive_verb_es}"
    page_content = Net::HTTP.get(URI.parse(final_url))

    JSON.parse page_content.match(/window\.SD_COMPONENT_DATA = (.+)/).to_a.last[0..-2]
  end

  def read_from_console(label, default = '')
    Readline.pre_input_hook = -> do
      Readline.insert_text(default)
      Readline.redisplay

      # Remove the hook right away.
      Readline.pre_input_hook = nil
    end

    Readline.readline(label, false)
  end
end
