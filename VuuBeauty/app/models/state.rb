class State < ApplicationRecord
  validates   :state, presence: true, length: { is: 2 }
  before_save :upcase_state_code
  has_many    :addresses
  
  private
    
    def upcase_state_code
      self.state = state.upcase
    end
end
