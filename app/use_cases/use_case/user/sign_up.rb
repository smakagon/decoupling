module UseCase
  module User
    class SignUp < UseCase::Base
      def call(attrs, callbacks)
        user = repository.new_entity(attrs)
        repository.save(user) ? callbacks[:success].call(user) : callbacks[:failure].call(user)
      end
    end
  end
end
