# TTPS 2019
# Requisitos.

* Ruby version --> 2.6.5
* MySQL
* Bundler

# Dependencias del sistema.

- Para unir la gema mysql2 con la libreria libmysql: https://www.rubydoc.info/gems/mysql2/0.5.3

# Configuración.

- `git clone https://github.com/nac1236/tpi_rails.git`, para obtener el proyecto.

- Ejecutar `bundle install`, luego de la descarga para instalar todas las dependencias.

- Editar las credenciales de acceso a la base de datos en el archivo config/database.yml, según corresponda.

# Creación de la base de datos.

- Levantar el servidor de la base de datos.

- Desde una terminal ejecutar --> `bin/rails db:create`

# Iniciar el servidor.

- Desde una terminal ejecutar --> `bin/rails s`

# Rutas.

 GET "/home" Retorna "Hola mundo!".

