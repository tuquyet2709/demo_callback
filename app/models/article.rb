class Article
  extend ActiveModel::Callbacks

  define_model_callbacks :publish, :only => [:before, :after]

  before_publish :check_publishability
  after_publish  :notify_subscribers

  def publish
    run_callbacks :publish do
      puts "Publishing article..."
    end
  end

  private

  def check_publishability
    puts "Checking publishability rules..."
  end

  def notify_subscribers
    puts "Notifying subscribers..."
  end

end