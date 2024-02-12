from convert_to_object import ORGANIZATION_OBJECT

TXT_FILE = open('insert data.txt', "w", encoding="utf-8")
municipality_id = 1
district_id = 1

for i, department in enumerate(ORGANIZATION_OBJECT):
  TXT_FILE.write(f"INSERT INTO departamentos (id , nombre) VALUES ({i + 1}, '{' '.join([str.capitalize() for str in department.split(' ')])}');\n")
  
  #? Municipios
  for j, municipality in enumerate(ORGANIZATION_OBJECT[department]):
    TXT_FILE.write(f"INSERT INTO municipios (id , nombre, departamento_id) VALUES ({municipality_id}, '{' '.join([str.capitalize() for str in municipality.split(' ')])}', {i + 1});\n")
    
    #? Distritos
    for k, district in enumerate(ORGANIZATION_OBJECT[department][municipality]):
      TXT_FILE.write(f"INSERT INTO distritos (id , nombre, municipio_id) VALUES ({district_id}, '{' '.join([str.capitalize() for str in district.split(' ')])}', {municipality_id});\n")
      district_id += 1

    municipality_id += 1
    
TXT_FILE.close()

READ_FILE = open('insert data.txt', "r", encoding="utf-8").read()
