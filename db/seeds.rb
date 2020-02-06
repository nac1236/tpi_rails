# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ClienteDependiente.create(nombre:"Manuel Diaz", codigo_tipo_responsable:2, email:"manuel@hotmail.com")
PhoneNumber.create(number:"460 1234", cliente_dependiente_id: ClienteDependiente.last )
ClienteDependiente.create(nombre:"Juan Perez", codigo_tipo_responsable:1, email:"juan@hotmail.com")
PhoneNumber.create(number:"460 3434", cliente_dependiente_id: ClienteDependiente.last )
ClienteDependiente.create(nombre:"Elias Sanchez", codigo_tipo_responsable:3, email:"elias@gmail.com")
PhoneNumber.create(number:"425 1234", cliente_dependiente_id: ClienteDependiente.last )
ClienteAutonomo.create(nombre:"Leandro Reynoso", codigo_tipo_responsable:3, email:"leandro@gmail.com", tipo_cliente: "persona")
PhoneNumber.create(number:"425 5555", cliente_dependiente_id: ClienteAutonomo.last )
ClienteAutonomo.create(razon_social:"El morenito", codigo_tipo_responsable:5, email:"morenito@gmail.com", tipo_cliente: "empresa")
PhoneNumber.create(number:"425 5050", cliente_dependiente_id: ClienteAutonomo.last )
PhoneNumber.create(number:"221 6437321", cliente_dependiente_id: ClienteAutonomo.last )