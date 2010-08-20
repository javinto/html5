require 'test_helper'

class Html5FormHelperTest < ActionView::TestCase
  tests ActionView::Helpers::Html5FormHelper
  
  def search_field
    expected = %{<input id="contact_notes_query" size="30" name="contact[notes_query]" type="search" />}
    assert_dom_equal(expected, search_field("contact", "notes_query"))
  end

  def test_telephone_field
    expected = %{<input id="user_cell" size="15" name="user[cell]" type="tel" />}
    assert_dom_equal(expected, telephone_field("user", "cell"))
  end

  def test_url_field
    expected = %{<input id="user_homepage" size="30" name="user[homepage]" type="url" />}
    assert_dom_equal(expected, url_field("user", "homepage"))
  end

  def test_email_field
    expected = %{<input id="user_address" size="30" name="user[address]" type="email" />}
    assert_dom_equal(expected, email_field("user", "address"))
  end

  def test_number_field
    expected = %{<input name="order[quantity]" size="30" max="9" id="order_quantity" type="number" min="1" />}
    assert_dom_equal(expected, number_field("order", "quantity", :in => 1...10))
  end

  def test_range_input
    expected = %{<input name="hifi[volume]" step="0.1" size="30" max="11" id="hifi_volume" type="range" min="0" />}
    assert_dom_equal(expected, range_field("hifi", "volume", :in => 0..11, :step => 0.1))
  end

end
