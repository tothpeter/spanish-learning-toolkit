numbers_basic = [
  [ '1', 'uno' ],
  [ '2', 'dos' ],
  [ '3', 'tres' ],
  [ '4', 'cuatro' ],
  [ '5', 'cinco' ],
  [ '6', 'seis' ],
  [ '7', 'siete' ],
  [ '8', 'ocho' ],
  [ '9', 'nueve' ]
]

numbers_10_29 = [
  [ '10', 'diez' ],
  [ '10', 'diez' ],
  [ '10', 'diez' ],
  [ '11', 'once' ],
  [ '11', 'once' ],
  [ '12', 'doce' ],
  [ '12', 'doce' ],
  [ '12', 'doce' ],
  [ '13', 'trece' ],
  [ '13', 'trece' ],
  [ '13', 'trece' ],
  [ '14', 'catorce' ],
  [ '15', 'quince' ],
  [ '15', 'quince' ],
  [ '15', 'quince' ],
  [ '15', 'quince' ],
  [ '16', 'dieciséis' ],
  [ '17', 'diecisiete' ],
  [ '18', 'dieciocho' ],
  [ '19', 'diecinueve' ],
  [ '20', 'veinte' ],
  [ '21', 'veintiuno' ],
  [ '22', 'veintidós' ],
  [ '23', 'veintitrés' ],
  [ '24', 'veinticuatro' ],
  [ '25', 'veinticinco' ],
  [ '26', 'veintiséis' ],
  [ '27', 'veintisiete' ],
  [ '28', 'veintiocho' ],
  [ '29', 'veintinueve' ]
]

numbers_tens = [
  ['3', 'treinta'],
  ['4', 'cuarenta'],
  ['4', 'cuarenta'],
  ['5', 'cincuenta'],
  ['6', 'sesenta'],
  ['7', 'setenta'],
  ['8', 'ochenta'],
  ['9', 'noventa']
]

numbers_hundreds = [
  ['1', 'ciento'],
  ['2', 'doscientos'],
  ['3', 'trescientos'],
  ['4', 'cuatrocientos'],
  ['5', 'quinientos'],
  ['6', 'seiscientos'],
  ['7', 'setecientos'],
  ['8', 'ochocientos'],
  ['9', 'novecientos'],
]


final_numbers = []

final_numbers += numbers_basic
final_numbers += numbers_10_29

numbers_tens.each do |number_prefix, text_prefix|
  numbers_basic.each do |number_postfix, text_postfix|
    number = "#{number_prefix}#{number_postfix}"
    text = "#{text_prefix} y #{text_postfix}"

    final_numbers << [number, text]
  end
end

while true
  final_numbers.shuffle!.shuffle!.shuffle!
  puts "Shuffle"

  final_numbers.each do |number, text|
    puts number
    STDIN.getc.chr
    puts text
    STDIN.getc.chr
    system "clear"
  end
end

# while true
#   number, text = final_numbers.to_a.sample
#   puts number
#   STDIN.getc.chr
#   puts text
#   STDIN.getc.chr
#   system "clear"
# end
