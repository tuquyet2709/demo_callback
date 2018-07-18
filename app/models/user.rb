class User < ApplicationRecord
  before_save :upcase_name, only: [:edit, :create, :show, :update]
  before_update do
    self.email += "@gmail.com"
  end
  after_destroy { |user| logger.info( "=================User #{user.id} was destroyed=================" ) }

  after_initialize do
    puts ">>>>>>>>>>>>>> You have initialized an object!"
  end

  after_find do
    puts ">>>>>>>>>>>>>> You have found an object!"
  end

  after_touch do
    puts ">>>>>>>>>>>>>> You have touched an object"
  end


  after_save do
    puts ">>>>>>>>>>>>>> after_save"
  end

  around_save :put_around

  private

  def upcase_name
    name.upcase!
  end

  def put_around
    puts ">>>>>>>>>>>>>> around_save -before"
    yield
    puts ">>>>>>>>>>>>>> around_save -after"
  end
end
