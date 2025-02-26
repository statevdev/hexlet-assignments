# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  completed   :boolean
#  creator     :string
#  description :text
#  name        :string
#  performer   :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  validates :name, :status, :creator, presence: true, format: {
    with: /\A[a-zA-Z]+\z/,
    message: 'only allows letters'
  }
  validates :performer, format: {
    with: /\A[a-zA-Z]+\z/,
    message: 'only allows letters'
  }
  validates :completed, inclusion: { in: [true, false] }
end
