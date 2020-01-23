class SessionsController < ApplicationController

    def create
        #todo esto tal vez deberia hacerse en el controlador de user y session solo deberia generar el token
        if( params[:u] and params[:p])
            user = User.find_by(username: params[:u])
            if (user)
                if (user.password == params[:p])
                    jwt = JWT.encode(
                        {user_id: user.id, exp: (Time.now + 30.min).to_i},
                        Rails.application.secrets.secret_key_base,
                        'HS256')
                end
            end
        end
    end

end
