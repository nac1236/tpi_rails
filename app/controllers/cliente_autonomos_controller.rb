include SessionsHandling

class ClienteAutonomosController < ApplicationController
    before_action :is_authenticated?

    skip_before_action :verify_authenticity_token
end
