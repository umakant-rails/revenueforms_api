require "test_helper"

class ContactMsgsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_msg = contact_msgs(:one)
  end

  test "should get index" do
    get contact_msgs_url, as: :json
    assert_response :success
  end

  test "should create contact_msg" do
    assert_difference("ContactMsg.count") do
      post contact_msgs_url, params: { contact_msg: { description: @contact_msg.description, email: @contact_msg.email, name: @contact_msg.name, subject: @contact_msg.subject } }, as: :json
    end

    assert_response :created
  end

  test "should show contact_msg" do
    get contact_msg_url(@contact_msg), as: :json
    assert_response :success
  end

  test "should update contact_msg" do
    patch contact_msg_url(@contact_msg), params: { contact_msg: { description: @contact_msg.description, email: @contact_msg.email, name: @contact_msg.name, subject: @contact_msg.subject } }, as: :json
    assert_response :success
  end

  test "should destroy contact_msg" do
    assert_difference("ContactMsg.count", -1) do
      delete contact_msg_url(@contact_msg), as: :json
    end

    assert_response :no_content
  end
end
