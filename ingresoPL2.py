import random
from datetime import datetime, timedelta

matriculas_generadas = set()
cif_generados = set()
dni_generados = set()

def generar_matricula():
    while True:
            matricula = f"{random.randint(0, 9999):04d} {random.choice('BCDFGHJKLMNPRSTVWXYZ')}{''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ', k=2))}"
            if matricula not in matriculas_generadas:
                matriculas_generadas.add(matricula)
                return matricula
def obtener_matricula_existente():
    return random.choice(list(matriculas_generadas))

def generar_dni():
    while True:
            letras = 'TRWAGMYFPDXBNJZSQVHLCKE'
            numeros = ''.join(random.choices('0123456789', k=8))
            dni = f'{numeros}{random.choice(letras)}'
            if dni not in dni_generados:
                dni_generados.add(dni)
                return dni
def obtener_dni_existente():
    if dni_generados:
        return random.choice(list(dni_generados))
    else:
        raise ValueError("No existing DNIs generated yet")

# Función para generar un CIF aleatorio
def generar_cif():
    cif = ''.join(random.choices('0123456789', k=8))
    letra = random.choice('ABCDEFGHJKLMNPQRSUVW')
    return cif + letra

def generar_cif():
    while True:
        cif = ''.join(random.choices('0123456789', k=8))+random.choice('ABCDEFGHJKLMNPQRSUVW')
        if  cif  not in cif_generados:
            cif_generados.add(cif)
            return cif
cif_generados = set()

def obtener_cif_existente():
    return random.choice(list(cif_generados))




# Definir marcas y modelos, nombres ficticios
marcas = ["Ford", "Toyota", "Volkswagen", "Chevrolet", "Renault", "BMW", "Mercedes-Benz", "Audi", "Honda", "Hyundai"]
modelos = ["Focus", "Corolla", "Golf", "Cruze", "Clio", "3 Series", "C-Class", "A4", "Civic", "Elantra"]
nombres = ["Juan", "María", "Luis", "Ana", "Carlos", "Sara", "Pedro", "Laura", "Diego", "Elena"]
import random

# Lista de marcas
marcas = ["Subaru", "Volvo", "Lexus", "Infiniti", "Mitsubishi", "Chrysler", "Buick", "Cadillac", "Lincoln", "Acura", "Land Rover", "Jaguar", "Porsche", "Ferrari", "Lamborghini", "Maserati", "Alfa Romeo", "Bugatti", "Tesla", "Mini"]

# Lista de modelos
modelos = ["Mustang", "Rav4", "Passat", "Malibu", "Kangoo", "X5", "CLA", "Q5", "Accord", "Santafe", "500", "Compass", "Altima", "Stinger", "Optima", "MX-5", "Challenger", "Expedition", "Tiguan", "Wrangler"]

# Lista de nombres 
nombres = ["Fernanda", "Ricardo", "Isabel", "Guillermo", "Olivia", "Mariano", "Beatriz", "Mateo", "Diana", "Emilio", "Alicia", "Sergio", "Carolina", "Raul", "Esther", "Federico", "Elisa", "Tomás", "Miriam", "Víctor"]

# Lista de provincias españolas
provincias = [
    "Álava", "Albacete", "Alicante", "Almería", "Asturias", "Ávila", "Badajoz", "Barcelona", "Burgos", "Cáceres",
    "Cádiz", "Cantabria", "Castellón", "Ciudad Real", "Córdoba", "Cuenca", "Gerona", "Granada", "Guadalajara",
    "Guipúzcoa", "Huelva", "Huesca", "Islas Baleares", "Jaén", "La Coruña", "La Rioja", "Las Palmas", "León",
    "Lérida", "Lugo", "Madrid", "Málaga", "Murcia", "Navarra", "Orense", "Palencia", "Pontevedra", "Salamanca",
    "Segovia", "Sevilla", "Soria", "Tarragona", "Santa Cruz de Tenerife", "Teruel", "Toledo", "Valencia", "Valladolid",
    "Vizcaya", "Zamora", "Zaragoza"
]

# Generar datos para empresas
with open ('E:\\archivos\\archivo_empresas.txt', 'w') as archivo_empresas:
    for _ in range(10000):  # Generar datos para 10,000 empresas
        cif = generar_cif()
        nombre_empresa = f"nombre_empresa{cif}"
        direccion = f"Dirección{cif}"
        provincia = random.choice(provincias)
        email = f"correo{cif}@gmail.com"
        telefono = '6' + ''.join(random.choice("0123456789") for _ in range(8))
        # Escribir en el archivo
        archivo_empresas.write(f"{cif},{nombre_empresa},{direccion},{provincia},{email},{telefono}\n")

# Generar datos para conductores
with open ('E:\\archivos\\archivo_conductores.txt', 'w') as archivo_conductores:
    for _ in range(200000):  # Generar datos para 200,000 conductores
        dni = generar_dni()
        nombre = random.choice(nombres)
        fecha_contrato = datetime(random.randint(1980, 2020), random.randint(1, 12), random.randint(1, 28)).strftime('%Y-%m-%d')
        telefono = '6' + ''.join(random.choice("0123456789") for _ in range(8))
        salario = round(random.uniform(20000, 30000), 2)
        cif_empresa = obtener_cif_existente()  # Asignar CI de empresa aleatorio
        # Escribir en el archivo
        archivo_conductores.write(f"{dni},{nombre},{fecha_contrato},{telefono},{salario},{cif_empresa}\n")

# Generar datos para vehículos
with open ('E:\\archivos\\archivo_vehiculos.txt', 'w') as archivo_vehiculos:
    for _ in range(1000000):  # Generar datos para 1 millón de vehículos
        matricula = generar_matricula()
        marca = random.choice(marcas)
        modelo = random.choice(modelos)
        kilometros = random.randint(50000, 100000)
        fecha_matricula = datetime(random.randint(2000, 2020), random.randint(1, 12), random.randint(1, 28))
        dni_conductor = obtener_dni_existente()
        archivo_vehiculos.write(f"{matricula},{marca},{modelo},{kilometros},{fecha_matricula},{fecha_matricula.strftime('%Y-%m-%d')},{dni_conductor}\n")
        
with open ('E:\\archivos\\archivo_bultos.txt', 'w') as archivo_bultos:
    for i in range(20000000):  # Generar datos para 20,000,000 de bultos
        id_bulto = i + 1
        direccion_origen = f"Dirección Origen {id_bulto}"
        direccion_destino = f"Dirección Destino {id_bulto}"
        provincia_origen = random.choice(provincias)
        provincia_destino = random.choice(provincias)
        peso = round(random.uniform(0.1, 10), 2)  # Peso entre 100 gramos y 10 kilogramos
        fecha_salida = datetime(2023, 1, 1) + timedelta(days=random.randint(0, 364))  # Fecha aleatoria dentro de 2023
        fecha_llegada = fecha_salida + timedelta(days=random.randint(1, 10))  # Fecha de llegada entre 1 y 10 días después de la fecha de salida
        matricula_vehiculos = obtener_matricula_existente()
        id_cliente_clientes = random.randint(0, 1999999)  # ID de cliente aleatorio
        # Escribir en el archivo
        archivo_bultos.write(f"{id_bulto},{direccion_origen},{direccion_destino},{provincia_origen},{provincia_destino},{peso},{fecha_salida.strftime('%Y-%m-%d')},{fecha_llegada.strftime('%Y-%m-%d')},{matricula_vehiculos},{id_cliente_clientes}\n")

# Generar datos para clientes
with open ('E:\\archivos\\archivo_clientes.txt', 'w') as archivo_clientes:
    for i in range(2000000):  # Generar datos para 2,000,000 de clientes
        id_cliente = i + 1
        nombre_cliente = f"nombre_cliente{id_cliente}"
        direccion = f"Dirección{id_cliente}"
        provincia = random.choice(provincias)
        email = f"correo{id_cliente}@gmail.com"
        telefono = '6' + ''.join(random.choice("0123456789") for _ in range(8))
        # Escribir en el archivo
        archivo_clientes.write(f"{id_cliente},{nombre_cliente},{direccion},{provincia},{email},{telefono}\n")
