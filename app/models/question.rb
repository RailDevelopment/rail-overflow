class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  def solved
    found_solution = false

    self.answers.each do |a|
      if a.accepted
        found_solution = true
        break
      end
    end

    found_solution
  end
end
