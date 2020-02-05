class SessionsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        return unless verify_content_type_header
        return unless verify_accept_header

        if( params[:data][:attributes][:username] and params[:data][:attributes][:password])
            user = User.find_by(username: params[:data][:attributes][:username])
            if (user)
                if (user.password == params[:data][:attributes][:password])
                    jwt = JWT.encode(
                        {user_id: user.id, exp: (Time.now + 1800).to_i},
                        Rails.application.secrets.secret_key_base,
                        'HS256')
                        session = Session.new(jwt)
                        render json:  JSONAPI::ResourceSerializer.new(SessionResource).object_hash(SessionResource.new(session, nil))
                else
                    login_incorrecto(:not_found, "Contraseña incorrecta.")
                    #handle_exceptions( JSONAPI::Exceptions::RecordNotFound.new(id:"username"))
                end
            else
                login_incorrecto(:not_found, "No se encontro el usuario.")    
            end
        else
            login_incorrecto(:bad_request, "Bad request")
        end
    end

    def login_incorrecto(status, detail)
        response.status = status
        render json: JSONAPI::ErrorsOperationResult.new(status, JSONAPI::Error.new(title: "Login incorrecto.", detail: detail))
    end

end
