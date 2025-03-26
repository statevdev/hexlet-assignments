# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  test '#create' do
    visit posts_url

    click_on 'Show', match: :first
    fill_in 'post_comment[body]', with: 'test body'

    click_on 'Create Comment'

    assert_text 'Comment was successfully created.'
  end

  test '#update' do
    visit posts_url

    click_on 'Show', match: :first
    click_on 'Edit', match: :first

    click_on 'Update Comment'

    assert_text 'Comment was successfully updated.'
  end

  test '#destroy' do
    visit posts_url

    click_on 'Show', match: :first

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Comment was successfully destroyed.'
  end
end
