class Invoice < ActiveRecord::Base
  attr_accessible :comment, :paid_at, :status, :sum, :user_id

  belongs_to :user

  STATUSES = {pending: 'pending', accepted: 'paid', rejected: 'rejected'}


end
