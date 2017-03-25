module UseCase
  module User
    class DeleteProfile < UseCase::Base
      def call(user, callbacks)
        repository.delete(user) ? callbacks[:success].call : callbacks[:failure].call
      end
    end
  end
end
