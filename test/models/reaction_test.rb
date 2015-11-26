require 'test_helper'

class ReactionTest < ActiveSupport::TestCase

  test "it turns a block of text into an array" do
    @user_input = "help, me, 'obi wan', Kenobi, you're, my, only, hope"
    @reaction = Reaction.new
    @reaction.format_keywords_to_a(@user_input)
    assert @reaction.keywords.include?("help"), "Didn't capture first word, 'help'"
    assert @reaction.keywords.include?("obi wan"), "Didn't capture quoted phrase as independent"
    assert_not @reaction.keywords.include?("'obi wan'"), "Didn't strip starting and ending quotations from phrase"
    assert @reaction.keywords.include?("you're"), "Didn't properly include the apostrophe in a possessive"
  end

  test "it strips out double quotes at the start or end of the string" do
    @user_input = "help, me, 'obi wan', Kenobi, you're, my, only, hope"
    @reaction = Reaction.new
    @reaction.format_keywords_to_a(@user_input)
    assert @reaction.keywords.include?("obi wan"), "Didn't capture quoted string"
    assert_not @reaction.keywords.include?('"obi wan"'), "Failed to remove double quotes from string"
  end

  test "it downcases the array elements" do
    @user_input = "help, me, 'obi wan', Kenobi, you're, my, only, hope"
    @reaction = Reaction.new
    @reaction.format_keywords_to_a(@user_input)
    assert @reaction.keywords.include?("help"), "Didn't downcase first word, 'help'"
    assert @reaction.keywords.include?("obi wan"), "Didn't downcase quoted phrase words"
  end

  test "it downcases the URL" do
    @reaction = Reaction.new
    @reaction.url = "HTTP://www.imgur.com/token.jpg"
    @reaction.downcase_url
    assert @reaction.url = "http://www.imgur.com/token.jpg"
  end

  test "it makes sure that format_keywords_to_a and keywords_pretty are inverses of each other" do
    @reaction = Reaction.new
    @user_input = "help, me, 'obi wan', Kenobi, you're, my, only, hope"
    @reaction.format_keywords_to_a(@user_input)
    @initial_keywords = @reaction.keywords

    # Now simulate user not changing anything - it should still save/pass
    @user_input_2 = @reaction.keywords_pretty
    @reaction.format_keywords_to_a(@user_input_2)
    assert @initial_keywords == @reaction.keywords, "Failed to save without changes."
  end

  


end
