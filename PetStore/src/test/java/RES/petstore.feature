Feature:
  Scenario Outline: Añadir una mascota a la tienda
    Given url 'https://petstore.swagger.io/v2/pet'
    When def body = read ('data.json')
    And request body
    And  method post
    Then status 200
    Examples:
      | Vid        | Vcategory    | Vname    | VphotoUrls   | Vtags      | Vstatus     |
      | 980626997  | "CANES"      | "CHOCOLATE"  | "string"     | "string"   | "available" |

  Scenario: consultar la mascota ingresada previamente
    Given url 'https://petstore.swagger.io/v2/pet'
    When def body = read ('data.json')
    And request body
    And  method get
    And match body.id<any>
    Then  status 200

  Scenario: Actualizar el nombre de la mascota y el estatus de la mascota a 'sold'
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {'id': 980626999, 'category': {'id':0,'name': 'CANES'}, 'name': 'MILO','photoUrls':['string'],'tags':[{'id': 0,'name': 'string'}],'status': 'sold'}
    When method PUT
    Then  status 200
    * def categoria = response.category.name
    * def name = response.name
    * def status = response.status
    * assert name == 'MILO'
    * assert status == 'sold'

  Scenario: Consultar la mascota modificada por status (Busqueda por estatus)
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=sold'
    When  method get
    Then  status 200

