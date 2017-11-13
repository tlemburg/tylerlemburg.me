class Hash
  def checked?(key)
    self.has_key?(key) && self[key] == 'on'
  end
end

module Enumerable
  def sum
    self.reduce(:+)
  end
end

class Integer
  def seconds
    self
  end

  def minutes
    seconds * 60
  end

  def hours
    minutes * 60
  end

  def days
    hours * 24
  end

  def weeks
    days * 7
  end

  def years
    days * 365
  end

  def pluralize(word, suffix = 's')
    if self == 1
      return "#{self} #{word}"
    else
      return "#{self} #{word}#{suffix}"
    end
  end

  def amount_display
    # assumes this amount is in cents
    "$#{self / 100.0}"
  end

  alias_method :second, :seconds
  alias_method :minute, :minutes
  alias_method :hour, :hours
  alias_method :day, :days
  alias_method :week, :weeks
  alias_method :year, :years
end

class String
  def capitalize_all
    self.split('_').map(&:capitalize).join(' ').split(' ').map(&:capitalize).join(' ')
  end

  def urlify
    self.downcase.split(' ').join('-')
  end

  def deambiguize
    x = self.trim.downcase
    # remove "the" words
    x = x.split(' ').delete_if{|word| %w(a and the of an).include?(word)}.join(' ')
    # remove spaces, dashes, underscores
    x = x.gsub(' ','').gsub('-','').gsub('_','')
    # remove colons
    x = x.gsub(':', '')
    # strip out HTML (e.g. bold around keywords)
    x = x.gsub(%r{</?[^>]+?>}, '')
    # remove parens and periods and commas and bangs
    x = x.gsub('(', '').gsub(')','').gsub('.','').gsub(',','').gsub('\'','').gsub('!','')
  end

  def card_text_display
    self.gsub('$','').gsub('{0}','').gsub('{1}','').gsub('[x]','').gsub('#','')
  end

  def self.token
    return (1..20).to_a.map{(Random.rand(26) + 65).chr}.join
  end

  alias_method :trim, :strip
  alias_method :trim!, :strip!
end

class Time
  def to_ct
    self.getlocal
  end

  def midnight
    Time.new(self.year, self.month, self.day)
  end

  def week_start
    time = self
    until time.sunday?
      time = time - 1.day
    end
    time.midnight
  end

  def month_start
    Time.new(self.year, self.month, 1)
  end
end