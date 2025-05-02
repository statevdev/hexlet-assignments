# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @api_link = 'https://api.github.com/repos/bblimke/webmock'
    @repo_link = 'https://github.com/bblimke/webmock'
    @body = load_fixture('files/response.json')
    @repo_attrs = { link: @repo_link }
  end
  # BEGIN
  test 'should create repo' do
    stub_request(:get, @api_link)
      .to_return(
        status: 200,
        body: @body,
        headers: { 'Content-Type' => 'application/json' }
      )

    post repositories_path, params: { repository: @repo_attrs }

    repository = Repository.find_by(link: @repo_link)

    assert repository
    assert_redirected_to repositories_path
    assert_equal 'Success', flash[:notice]
  end
  # END
end
