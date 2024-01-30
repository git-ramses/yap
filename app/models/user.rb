# frozen_string_literal: true

# representation of User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[Read Member Admin].freeze

  belongs_to :team

  validates :role, inclusion: { in: ROLES }
  validates :email, presence: true

  def role_name
    role || 'Not set'
  end

  def team_name
    team&.display_name || 'Not set'
  end
end
