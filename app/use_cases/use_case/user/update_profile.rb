module UseCase
  module User
    class UpdateProfile < UseCase::Base
      def call(user, attrs, callbacks)
        user.assign_attributes(attrs)

        repository.save(user) ? callbacks[:success].call(user) : callbacks[:failure].call(user)
      end
    end
  end
end
