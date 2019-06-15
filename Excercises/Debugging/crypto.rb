# crypto.rb
class Crypto
  def initialize(text)
    @text = text
    @normalized_plaintext = text.gsub(/[^A-Za-z0-9]/, '').downcase
  end

  def normalize_plaintext
    @normalized_plaintext
  end

  def size
    plain_text_size = @normalized_plaintext.size
    Math.sqrt(plain_text_size).ceil
  end

  def plaintext_segments
    # turn text into an array of the proper segments
    @normalized_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    padded_segments = plaintext_segments.map do |string|
      string.size < size ? string + " " : string
    end
    padded_segments.map(&:chars).transpose.join.strip
  end
end


text = Crypto.new('If man was meant to stay on the grolund god would have given us roots')
p text.ciphertext