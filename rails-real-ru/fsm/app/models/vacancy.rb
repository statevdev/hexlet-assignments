# frozen_string_literal: true

class Vacancy < ApplicationRecord
  include AASM

  validates :title, presence: true
  validates :description, presence: true

  # BEGIN
  aasm whiny_transitions: false do
    # Начальное состояние
    state :on_moderate, initial: true
    state :archived, :published

    # Событие и переходы
    event :archive do
      transitions from: %i[published on_moderate], to: :archived
    end

    event :publish do
      transitions from: :on_moderate, to: :published
    end
  end
  # END
end
