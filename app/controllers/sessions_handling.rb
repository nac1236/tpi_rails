module SessionsHandling

    def is_authenticated?
        @user = User.find(decoded_auth_token[0]["user_id"]) if decoded_auth_token
    end

    def decoded_auth_token
        begin
            @decoded_token ||= JWT.decode(http_auth_header, Rails.application.secrets.secret_key_base, 'HS256')
        rescue
            print "Debe loguearse."
            render json: {errors: [{detail: "Debe loguearse.",code: 401, status: 401}]}, status: 401
        end
        return @decoded_token
    end

    def http_auth_header
        if request.headers['Authorization'].present?
          return request.headers['Authorization']
        else
          nil
        end
    end
end