//////////////////////////////////////////////////////////////
// NEO4J MOCK PRACTICAL – CRUD OPERATIONS
// Employee–Department Graph Database
// Author: Atharva
// Course: CSL702 – Big Data Analytics Lab
//////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
// STEP 0 — CLEAR DATABASE
//////////////////////////////////////////////////////////////

MATCH (n) DETACH DELETE n;


//////////////////////////////////////////////////////////////
// STEP 1 — CREATE DEPARTMENT NODES
//////////////////////////////////////////////////////////////

CREATE (:Department {d_no:"D1", d_name:"ICARE", e_mail:"icare@iut.fr"});
CREATE (:Department {d_no:"D2", d_name:"MINOS", e_mail:"minos@cict.fr"});


//////////////////////////////////////////////////////////////
// STEP 2 — CREATE EMPLOYEE NODES
//////////////////////////////////////////////////////////////

CREATE (:Employee {emp_no:"e1", emp_name:"Codd", dept:"D1"});
CREATE (:Employee {emp_no:"e2", emp_name:"Date", dept:"D1"});
CREATE (:Employee {emp_no:"e7", emp_name:"Darwen", dept:"D2"});
CREATE (:Employee {emp_no:"e12", emp_name:"Chen", dept:"D2"});


//////////////////////////////////////////////////////////////
// STEP 3 — CREATE BELONGS_TO RELATIONSHIPS
//////////////////////////////////////////////////////////////

MATCH (e:Employee), (d:Department)
WHERE e.dept = d.d_no
CREATE (e)-[:BELONGS_TO]->(d);


//////////////////////////////////////////////////////////////
// STEP 4 — READ OPERATIONS (QUERIES)
//////////////////////////////////////////////////////////////

// 4.1 View all nodes
MATCH (n) RETURN n;

// 4.2 View employee → department relationships
MATCH (e:Employee)-[r:BELONGS_TO]->(d:Department)
RETURN e, r, d;

// 4.3 View all employees in Department D1
MATCH (e:Employee)-[:BELONGS_TO]->(d:Department {d_no:"D1"})
RETURN e;


//////////////////////////////////////////////////////////////
// STEP 5 — UPDATE OPERATIONS
//////////////////////////////////////////////////////////////

// 5.1 Update employee name
MATCH (e:Employee {emp_no:"e1"})
SET e.emp_name = "Dr. Codd"
RETURN e;

// 5.2 Add new property to employee
MATCH (e:Employee {emp_no:"e2"})
SET e.salary = 60000
RETURN e;

// 5.3 Conditional update (add category)
MATCH (e:Employee)
WHERE e.emp_no STARTS WITH "e"
SET e.category = "Active"
RETURN e;


//////////////////////////////////////////////////////////////
// STEP 6 — CREATE NEW EMPLOYEE (ADD TO EXISTING GRAPH)
//////////////////////////////////////////////////////////////

CREATE (:Employee {emp_no:"e15", emp_name:"Jordan", dept:"D1"});

// Create relationship for new employee
MATCH (e:Employee {emp_no:"e15"}), (d:Department {d_no:"D1"})
CREATE (e)-[:BELONGS_TO]->(d);


//////////////////////////////////////////////////////////////
// STEP 7 — DELETE OPERATIONS
//////////////////////////////////////////////////////////////

// 7.1 Delete one employee
MATCH (e:Employee {emp_no:"e15"}) DETACH DELETE e;

// 7.2 Delete all employees belonging to department D2
MATCH (e:Employee)-[:BELONGS_TO]->(d:Department {d_no:"D2"})
DETACH DELETE e;

// 7.3 Delete everything (final cleanup)
MATCH (n) DETACH DELETE n;


//////////////////////////////////////////////////////////////
// END OF PRACTICAL
//////////////////////////////////////////////////////////////
