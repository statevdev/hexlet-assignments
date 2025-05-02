# frozen_string_literal: true

require 'octokit'

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(link)
    client = Octokit::Client.new

    octokit_repo = Octokit::Repository.from_url(link)

    github_data = client.repository(octokit_repo)

    repository = Repository.find_or_create_by(link: link)
    repository.fetch!

    if repository.update(
      repo_name: github_data[:name],
      owner_name: github_data[:owner][:login],
      description: github_data[:description],
      default_branch: github_data[:default_branch],
      watchers_count: github_data[:watchers_count],
      language: github_data[:language],
      repo_created_at: github_data[:created_at],
      repo_updated_at: github_data[:updated_at]
    )
      repository.fetch_complete!
    else
      repository.fetch_uncomplete!
    end
  end
end
