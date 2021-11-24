class String

  # Custom method for remove accent marks in string
  def remove_accents
    I18n.transliterate(self)
  end

  # Custom method for get first vowel in sting
  def first_vowel
    self.split("").each do |c|
      if 'aeiou'.include?(c)
        return c
      end
    end
  end

end
