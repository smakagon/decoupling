module UseCase
  module User
    class SignUp
      def self.call(attrs, callbacks, repository = UserRepository.new)
        new(attrs, callbacks, repository).call
      end

      def call
        user = repository.new_entity(attrs)

        if repository.save(user)
          callbacks[:success].call(user)
        else
          callbacks[:failure].call(user)
        end
      end

      private

      def initialize(attrs, callbacks, repository)
        @attrs = attrs
        @callbacks = callbacks
        @repository = repository
      end

      attr_reader :repository, :callbacks, :attrs
    end
  end
end
