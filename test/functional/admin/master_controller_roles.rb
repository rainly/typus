require 'test/helper'

class Admin::CategoriesControllerTest < ActionController::TestCase

  def test_should_allow_admin_to_add_a_category
    admin = typus_users(:admin)
    @request.session[:typus_user_id] = admin.id
    assert admin.can_perform?('Category', 'create')
  end

  def test_should_not_allow_designer_to_add_a_category
    designer = typus_users(:designer)
    @request.session[:typus_user_id] = designer.id
    get :new
    assert_response :redirect
    assert_equal "Designer can't perform action. (new)", flash[:notice]
    assert_redirected_to :action => :index
  end

  def test_should_allow_admin_to_destroy_a_category
    admin = typus_users(:admin)
    @request.session[:typus_user_id] = admin.id
    category = categories(:first)
    get :destroy, { :id => category.id, :method => :delete }
    assert_response :redirect
    assert_equal "Category successfully removed.", flash[:success]
    assert_redirected_to :action => :index
  end

  def test_should_not_allow_designer_to_destroy_a_category
    designer = typus_users(:designer)
    @request.session[:typus_user_id] = designer.id
    category = categories(:first)
    get :destroy, { :id => category.id, :method => :delete }
    assert_response :redirect
    assert_equal "Designer can't delete this item.", flash[:notice]
    assert_redirected_to :action => :index
  end

end