module UseCase
  module User
    class UpdateProfile
      def self.call(user, attrs, callbacks, repository = UserRepository.new)
        new(user, attrs, callbacks, repository).call
      end

      def call
        user.assign_attributes(attrs)

        if repository.save(user)
          callbacks[:success].call(user)
        else
          callbacks[:failure].call(user)
        end
      end

      private

      def initialize(user, attrs, callbacks, repository)
        @user = user
        @attrs = attrs
        @callbacks = callbacks
        @repository = repository
      end

      attr_reader :user, :attrs, :callbacks, :repository
    end
  end
end
