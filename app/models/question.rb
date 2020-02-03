class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  def solved
    self.answers.each do |a|
      if a.accepted
        true
      end
    end

    false
  end
end
