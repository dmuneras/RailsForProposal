require 'test_helper'

class RequestTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert RequestType.new.valid?
  end
end
