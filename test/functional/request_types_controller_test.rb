require 'test_helper'

class RequestTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => RequestType.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    RequestType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    RequestType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to request_type_url(assigns(:request_type))
  end

  def test_edit
    get :edit, :id => RequestType.first
    assert_template 'edit'
  end

  def test_update_invalid
    RequestType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => RequestType.first
    assert_template 'edit'
  end

  def test_update_valid
    RequestType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => RequestType.first
    assert_redirected_to request_type_url(assigns(:request_type))
  end

  def test_destroy
    request_type = RequestType.first
    delete :destroy, :id => request_type
    assert_redirected_to request_types_url
    assert !RequestType.exists?(request_type.id)
  end
end
