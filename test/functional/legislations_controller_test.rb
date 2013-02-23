require 'test_helper'

class LegislationsControllerTest < ActionController::TestCase
  setup do
    @legislation = legislations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:legislations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create legislation" do
    assert_difference('Legislation.count') do
      post :create, legislation: { affected_location: @legislation.affected_location, content: @legislation.content, date: @legislation.date, legislation_type: @legislation.legislation_type, num_for_votes: @legislation.num_for_votes, num_no_votes: @legislation.num_no_votes, ordinance_id: @legislation.ordinance_id, passed?: @legislation.passed?, sponsor: @legislation.sponsor, title: @legislation.title }
    end

    assert_redirected_to legislation_path(assigns(:legislation))
  end

  test "should show legislation" do
    get :show, id: @legislation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @legislation
    assert_response :success
  end

  test "should update legislation" do
    put :update, id: @legislation, legislation: { affected_location: @legislation.affected_location, content: @legislation.content, date: @legislation.date, legislation_type: @legislation.legislation_type, num_for_votes: @legislation.num_for_votes, num_no_votes: @legislation.num_no_votes, ordinance_id: @legislation.ordinance_id, passed?: @legislation.passed?, sponsor: @legislation.sponsor, title: @legislation.title }
    assert_redirected_to legislation_path(assigns(:legislation))
  end

  test "should destroy legislation" do
    assert_difference('Legislation.count', -1) do
      delete :destroy, id: @legislation
    end

    assert_redirected_to legislations_path
  end
end
