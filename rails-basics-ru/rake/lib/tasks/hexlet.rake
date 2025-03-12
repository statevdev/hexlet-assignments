require 'csv'

namespace :hexlet do
  desc "Import user from csv file"
  task :import_users, [:csv_name] => :environment do |_, args|
    csv_name = args[:csv_name]
    _, *arr_of_users = CSV.read(csv_name)

    arr_of_users.each do |user_data|
      first_name, last_name, birthday, email = user_data
      User.create(
        first_name:,
        last_name:,
        birthday: Date.strptime(birthday, '%m/%d/%Y'),
        email:
      )
    end
  end
end
