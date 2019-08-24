require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should sign up' do
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

  test 'should sign in' do
    post '/v1/users/sign_in', params: {
      email: 'jsrd98@gmail.com',
      password: '12345'
    }, as: :json

    assert_response 200
    assert_matches_json_schema response, 'users_sign_in'
  end

  test 'should sign out' do
    token = JsonWebToken.encode(user_id: @user.id)
    post '/v1/users/sign_out', headers: {'Authorization': token }

    assert_response 200
    assert_equal "{}", response.body
  end
end
