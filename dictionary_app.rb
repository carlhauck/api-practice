require "http"

puts
puts "Welcome to Gruff Dictionary."
while true
  puts
  puts "Gimme a damn word. Wanna quit? Enter 'q'."
  word = gets.chomp
  if word == "q"
    puts
    puts "Perfect. Less work for me."
    puts
    break
  else
    # Definition
    definition = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=YOURAPIKEY")
    puts
    puts "Definition: #{definition.parse[0]["text"]}"
    # Top Example
    top_example = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/topExample?useCanonical=false&api_key=YOURAPIKEY")
    puts
    puts "Top example: #{top_example.parse["text"]}"
    # Pronunciation
    pronunciation = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/pronunciations?useCanonical=false&limit=50&api_key=YOURAPIKEY")
    puts
    puts "Pronunciation: #{pronunciation.parse[0]["raw"]}"
    # Audio - opens audio file in default browser
    audio = HTTP.get("https://api.wordnik.com/v4/word.json/banana/audio?useCanonical=false&limit=50&api_key=YOURAPIKEY")
    system("open", "#{audio.parse[0]['fileUrl']}")
  end
end