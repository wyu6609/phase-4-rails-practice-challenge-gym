class Membership < ApplicationRecord
  belongs_to :gym
  belongs_to :client

  validates :gym_id, presence: true, uniqueness: true
  validates :client_id, presence: true, uniqueness: true
  validates :charge, presence: true
end
