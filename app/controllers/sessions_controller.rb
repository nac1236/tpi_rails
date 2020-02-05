class SessionsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        return unless verify_content_type_header

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
                    #retorno = JSONAPI::ErrorsOperationResult.new(:not_found, JSONAPI::Error.new(code: "404"))
                    
                    # En vez de crear un error voy a intentar levantar una excepcion
                    # probar mandar otro error --> 
                    handle_exceptions( JSONAPI::Exceptions::RecordNotFound.new(id:"username"))
                end
            end
        end
    end

end
