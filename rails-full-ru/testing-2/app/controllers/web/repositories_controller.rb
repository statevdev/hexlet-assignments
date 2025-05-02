# frozen_string_literal: true

# BEGIN
require 'octokit'
# END

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    # BEGIN
    client = Octokit::Client.new

    @octokit_repository = Octokit::Repository.from_url(permitted_params[:link])

    data = client.repository(@octokit_repository)

    repo_attrs = {
      link: permitted_params[:link],
      owner_name: data.owner.login,
      repo_name: data.name,
      description: data.description,
      default_branch: data.default_branch,
      watchers_count: data.watchers,
      language: data.language,
      repo_created_at: data.created_at,
      repo_updated_at: data.updated_at
    }

    @repository = Repository.new(repo_attrs)

    if @repository.save
      redirect_to repositories_path, notice: t('success')
    else
      render :new, status: :unprocessable_entity
    end
    # END
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
