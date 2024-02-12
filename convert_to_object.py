from organization import organization

current_organization = organization.split("DEPARTAMENTO DE ")[1:]
current_organization = [x.split("\n", 1) for x in current_organization]

current_organization = {x[0]: x[1].split("MUNICIPIO DE ")[1:] for x in current_organization}

departments = list(current_organization.keys())

for department in departments:
    current_organization[department] = {x.split("\n", 1)[0]: x.replace("\n", "").split("Distrito de ")[1:] for x in current_organization[department]}

ORGANIZATION_OBJECT = current_organization