module UseCase
  module User
    class DeleteProfile
      def self.call(user, callbacks, repository = UserRepository.new)
        new(user, callbacks, repository).call
      end

      def call
        repository.delete(user) ? callbacks[:success].call : callbacks[:failure].call
      end

      private

      def initialize(user, callbacks, repository)
        @user = user
        @callbacks = callbacks
        @repository = repository
      end

      attr_reader :user, :callbacks, :repository
    end
  end
end
