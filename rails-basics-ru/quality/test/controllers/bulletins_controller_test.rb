require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'can open all bulletins page' do
    get root_path

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'can open one bulletin page' do
    get bulletin_path(bulletins(:bulletin1))

    assert_response :success
    assert_select 'h1', 'Bulletin Page'
    assert_select 'h4', 'Title 1'
    assert_select 'p', 'Body 1'
  end
end
