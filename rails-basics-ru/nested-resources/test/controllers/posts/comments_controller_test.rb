require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = post_comments(:one)
  end

  test 'should create comment' do
    assert_difference('@post.post_comments.count', 1) do
      post post_comments_path(@post), params: { post_comment: { content: 'Новый комментарий' } }
    end
    assert_redirected_to post_path(@post)
  end

  test 'should not create invalid comment' do
    assert_no_difference('@post.post_comments.count') do
      post post_comments_path(@post), params: { post_comment: { content: '' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should get edit' do
    get edit_post_comment_path(@post, @comment)
    assert_response :success
  end

  test 'should update comment' do
    patch post_comment_path(@post, @comment), params: { post_comment: { content: 'Обновленный комментарий' } }
    assert_redirected_to post_path(@post)
    @comment.reload
    assert_equal 'Обновленный комментарий', @comment.content
  end

  test 'should not update invalid comment' do
    patch post_comment_path(@post, @comment), params: { post_comment: { content: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy comment' do
    assert_difference('@post.post_comments.count', -1) do
      delete post_comment_path(@post, @comment)
    end
    assert_redirected_to post_path(@post)
  end
end
