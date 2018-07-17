class User < ApplicationRecord
  before_save :upcase_name, only: [:edit, :create, :show, :update]
  before_update do
    self.email += "@gmail.com"
  end
  after_destroy { |user| logger.info( "=================User #{user.id} was destroyed=================" ) }

  private

  def upcase_name
    name.upcase!
  end

end