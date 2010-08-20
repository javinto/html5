require 'test_helper'

class Html5FormTagHelperTest < ActionView::TestCase
  tests ActionView::Helpers::Html5FormTagHelper
  
  def test_search_field_tag
    expected = %{<input id="query" name="query" type="search" />}
    assert_dom_equal(expected, search_field_tag("query"))
  end

  def telephone_field_tag
    expected = %{<input id="cell" name="cell" type="tel" />}
    assert_dom_equal(expected, telephone_field_tag("cell"))
  end

  def test_url_field_tag
    expected = %{<input id="homepage" name="homepage" type="url" />}
    assert_dom_equal(expected, url_field_tag("homepage"))
  end

  def test_email_field_tag
    expected = %{<input id="address" name="address" type="email" />}
    assert_dom_equal(expected, email_field_tag("address"))
  end

  def test_number_field_tag
    expected = %{<input name="quantity" max="9" id="quantity" type="number" min="1" />}
    assert_dom_equal(expected, number_field_tag("quantity", nil, :in => 1...10))
  end

  def test_range_input_tag
    expected = %{<input name="volume" step="0.1" max="11" id="volume" type="range" min="0" />}
    assert_dom_equal(expected, range_field_tag("volume", nil, :in => 0..11, :step => 0.1))
  end


end
