require 'readline'

class Main
  def self.start
    pronouns_en = ['I', 'you', 'he', 'we', 'you all', 'they']
    pronouns_es = ['yo', 'tú', 'él', 'nosotros', 'vosotro', 'ellos']

    printf 'Infinitive verb in Español: '
    infinitive_verb_es = gets.chomp

    base_url = 'https://www.spanishdict.com/conjugate'

    final_url = "#{base_url}/#{infinitive_verb_es}"
    page_content = Net::HTTP.get(URI.parse(final_url))

    document = Nokogiri::HTML(page_content)

    infinitive_verb_en = document.search('#quickdef1-es').first.content

    infinitive_base_verb_en = English::SimplePast.fetch(infinitive_verb_en)

    infinitive_past_verb_en = read_from_console('Infinitive verb in English: ', infinitive_base_verb_en)

    conjugation_es = document.search('.conjugation [data-tense="preteritIndicative"]').map(&:content)
    conjugation_en = [infinitive_past_verb_en] * 6

    conjugation_with_pron_en = pronouns_en.zip(conjugation_en).map { |a| a.join(' ') }
    conjugation_with_pron_es = pronouns_es.zip(conjugation_es).map { |a| a.join(' ') }

    conjugation_with_pron_en.zip(conjugation_with_pron_es).each do |conjugation_en, conjugation_es|
      puts "#{conjugation_en}\t#{conjugation_es}"
    end
  end

  def self.read_from_console(label, default = '')
    Readline.pre_input_hook = -> do
      Readline.insert_text(default)
      Readline.redisplay

      # Remove the hook right away.
      Readline.pre_input_hook = nil
    end

    Readline.readline(label, false)
  end
end