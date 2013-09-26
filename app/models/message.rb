class Message < ActiveRecord::Base
  attr_accessible :job_id, :reason, :receiver_id, :sender_id, :read_at
  #For message functionality
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :foreign_key => 'receiver_id'
  belongs_to :job
end
