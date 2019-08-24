require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user_token = JsonWebToken.encode(user_id: @user.id)
  end

  test 'should user sign up' do
    assert_difference('User.count') do
      post '/v1/users/sign_up', params: {
        name: 'Test user',
        email: 'user@test.com',
        password: '12345',
        password_confirmation: '12345'
      }, as: :json
    end

    assert_response 201
    assert_matches_json_schema response, 'users_sign_up'
  end

  test 'should user sign in' do
    post '/v1/users/sign_in', params: {
      email: 'jsrd98@gmail.com',
      password: '12345'
    }, as: :json

    assert_response 200
    assert_matches_json_schema response, 'users_sign_in'
  end

  test 'should user sign out' do
    post '/v1/users/sign_out', headers: { 'Authorization': @user_token }

    updated_user = User.find(@user.id)

    assert_response 200
    assert_equal '{}', response.body
    assert_equal @user_token, updated_user.last_token
  end
end
