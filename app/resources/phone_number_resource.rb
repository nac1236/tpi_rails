class PhoneNumberResource < JSONAPI::Resource
    attributes :number

    filter :cliente_dependiente
    filter :cliente_autonomo
end