class Subscription < ApplicationRecord
  has_many :events, class_name: 'Subscription::Event'
  belongs_to :user, primary_key: :aggregate_id
end
