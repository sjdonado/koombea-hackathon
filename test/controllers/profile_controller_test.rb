require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user_token = JsonWebToken.encode(user_id: @user.id)
  end

  test 'should show user profile' do
    get '/v1/profile', headers: { 'Authorization': @user_token }

    assert_response 200
    assert_matches_json_schema response, 'users_sign_up'
  end

  test 'should update user profile' do
    put '/v1/profile', headers: { 'Authorization': @user_token }, params: {
      address: 'Test address',
      phone: '+5712345'
    }, as: :json

    updated_user = User.find(@user.id)

    assert_response 200
    assert_matches_json_schema response, 'users_sign_up'
    assert_equal 'Test address', updated_user.address
    assert_equal '+5712345', updated_user.phone
  end

  test 'should update user profile photo' do
    file = fixture_file_upload('docs/test.png')
    headers = {
      'Authorization': @user_token,
      'content-type': 'multipart/form-data'
    }
    put '/v1/profile/photo', headers: headers, params: { file: file }

    updated_user = User.find(@user.id)

    assert_response 200
    assert_equal '{}', response.body
    assert_not_equal nil, updated_user.photo
  end
end
