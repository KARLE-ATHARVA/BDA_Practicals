MATCH (n) DETACH DELETE n;

CREATE (:Class {class_name:"Introduction to Jazz", credit_hours:5, class_id:101});
CREATE (:Class {class_name:"Introduction to Guitar", credit_hours:4, class_id:102});
CREATE (:Class {class_name:"Advanced Guitar", credit_hours:5, class_id:103});
CREATE (:Class {class_name:"Jazz Band", credit_hours:4, class_id:104});

CREATE (:Student {student_id:1001, student_name:"Wayne Gentry", dob:"3/15/2005"});
CREATE (:Student {student_id:1002, student_name:"Cathy Baker", dob:"1/22/2005"});
CREATE (:Student {student_id:1003, student_name:"Zayan Dean", dob:"12/5/2004"});
CREATE (:Student {student_id:1004, student_name:"Issa McLeod", dob:"6/18/2005"});
CREATE (:Student {student_id:1005, student_name:"Judd Wilkes", dob:"4/8/2005"});
CREATE (:Student {student_id:1006, student_name:"Saiby Diloucol", dob:"2/9/2004"});

MATCH (c:Class {class_id:101}), (s:Student) WHERE s.student_id IN [1001,1002]
CREATE (s)-[:ENROLLED_IN]->(c);

MATCH (c:Class {class_id:102}), (s:Student) WHERE s.student_id IN [1003,1004]
CREATE (s)-[:ENROLLED_IN]->(c);

MATCH (c:Class {class_id:103}), (s:Student) WHERE s.student_id IN [1002,1005]
CREATE (s)-[:ENROLLED_IN]->(c);

MATCH (c:Class {class_id:104}), (s:Student) WHERE s.student_id IN [1001,1006]
CREATE (s)-[:ENROLLED_IN]->(c);

MATCH (n) RETURN n;

MATCH (s:Student)-[r:ENROLLED_IN]->(c:Class)
RETURN s,r,c;

MATCH (s:Student {student_id:1003})
SET s.student_name = "Zayan Dean Jr.";

CREATE (:Student {student_id:1010, student_name:"New Student", dob:"1/1/2006"});

MATCH (s:Student {student_id:1010}), (c:Class {class_id:101})
CREATE (s)-[:ENROLLED_IN]->(c);

MATCH (s:Student {student_id:1010}) DETACH DELETE s;
