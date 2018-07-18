def define_model_callbacks(*callbacks)
      options = callbacks.extract_options!
      options = {
         :terminator => "result == false",
         :scope => [:kind, :name],
         :only => [:before, :around, :after]
      }.merge(options)

      types   = Array.wrap(options.delete(:only))

      callbacks.each do |callback|
        define_callbacks(callback, options)

        types.each do |type|
          send("_define_#{type}_model_callback", self, callback)
        end
      end
    end

    def _define_before_model_callback(klass, callback) #:nodoc:
      klass.class_eval <<-CALLBACK, __FILE__, __LINE__ + 1
        def self.before_#{callback}(*args, &block)
          set_callback(:#{callback}, :before, *args, &block)
        end
      CALLBACK
    end

    def _define_around_model_callback(klass, callback) #:nodoc:
      klass.class_eval <<-CALLBACK, __FILE__, __LINE__ + 1
        def self.around_#{callback}(*args, &block)
          set_callback(:#{callback}, :around, *args, &block)
        end
      CALLBACK
    end

    def _define_after_model_callback(klass, callback) #:nodoc:
      klass.class_eval <<-CALLBACK, __FILE__, __LINE__ + 1
        def self.after_#{callback}(*args, &block)
          options = args.extract_options!
          options[:prepend] = true
          options[:if] = Array.wrap(options[:if]) << "!halted && value != false"
          set_callback(:#{callback}, :after, *(args << options), &block)
        end
      CALLBACK
    end
  end
end
