module AthenaHealth
  class ServerError               < StandardError; end
  class UnauthorizedError         < ServerError; end
  class IncorrectPermissionsError < ServerError; end
  class ForbiddenError            < ServerError; end
  class NotFoundError             < ServerError; end
  class InternalServerError       < ServerError; end
  class ServiceUnavailableError   < ServerError; end

  class ValidationError < StandardError
    attr_reader :details

    def initialize(details)
      @details = details
    end
  end


  class Error
    ERROR_TYPES = {
      401 => UnauthorizedError,
      402 => IncorrectPermissionsError,
      403 => ForbiddenError,
      404 => NotFoundError,
      500 => InternalServerError,
      503 => ServiceUnavailableError,
    }

    def initialize(code:)
      @code = code
    end

    def render
      fail ERROR_TYPES[@code]
    end
  end
end
