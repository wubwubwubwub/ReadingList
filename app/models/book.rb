class Book < ActiveRecord::Base
  
  def finished?
    self.finished_on.present?
  end
  
end
