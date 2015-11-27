class Reaction < ActiveRecord::Base

  before_validation :downcase_url

  # Carrierwave
  mount_uploader :image, ReactionUploader

  belongs_to :user

  def self.search(search)
    if search
      find(:all, :conditions => ['keywords LIKE ?', "%#{search}%"])

    else
      find(:all)
    end
  end

  # Called from the controller, formats the user-inputted block of text into
  # array of words
  def format_keywords_to_a(input_text)
    words = input_text.split(",")
    words.map! { |word| word.strip.delete('"') }
    # Remove leading quotations
    words.map! { |word| word.match(/^'/) ? word[1..-1] : word }
    words.map! { |word| word.match(/^"/) ? word[1..-1] : word }
    # Remove trailing quotations
    words.map! { |word| word.match(/'$/) ? word[0..-2] : word }
    words.map! { |word| word.match(/"$/) ? word[0..-2] : word }
    self.keywords = words
  end

  def keywords_pretty
    keywords.to_s.gsub(/["\[\]]/, "")
  end

  def downcase_url
    self.url = self.url.downcase if url
  end




end
