CREATE DATABASE StudentRecords;
USE StudentRecords;

-- Table for storing department information
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    building_location VARCHAR(100)
);

-- Table for storing student information
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    department_id INT,
    CONSTRAINT chk_student_age CHECK (date_of_birth <= DATE_SUB(CURRENT_DATE, INTERVAL 13 YEAR)),
    CONSTRAINT fk_student_department FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id) ON DELETE SET NULL
);

-- Table for storing instructor information
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    office_number VARCHAR(20),
    department_id INT,
    CONSTRAINT fk_instructor_department FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id) ON DELETE SET NULL
);

-- Table for storing course information
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits DECIMAL(3,1) NOT NULL CHECK (credits > 0),
    instructor_id INT,
    department_id INT,
    CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id) 
        REFERENCES Instructors(instructor_id) ON DELETE SET NULL,
    CONSTRAINT fk_course_department FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id) ON DELETE CASCADE
);

-- Table for storing student enrollments in courses
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade DECIMAL(4,2) CHECK (grade BETWEEN 0 AND 100),
    CONSTRAINT uq_student_course UNIQUE (student_id, course_id),
    CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id) 
        REFERENCES Students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id) 
        REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Table for tracking student grades with additional normalization
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    assignment_name VARCHAR(100) NOT NULL,
    score DECIMAL(5,2) CHECK (score >= 0),
    max_score DECIMAL(5,2) NOT NULL CHECK (max_score > 0),
    assignment_date DATE NOT NULL,
    CONSTRAINT fk_grade_enrollment FOREIGN KEY (enrollment_id) 
        REFERENCES Enrollments(enrollment_id) ON DELETE CASCADE,
    CONSTRAINT chk_score_limit CHECK (score <= max_score)
);
--The departments cover a range of academic descipines including sciences, humanities, social sciences, and enineering;
--which is critical for a comprehensive student records database.
INSERT INTO Departments (department_name, building_location) VALUES
('Computer Science', 'Technology Building'),
('Mathematics', 'Science Hall'),
('Physics', 'Science Hall'),
('Chemistry', 'Research Building'),
('Biology', 'Life Sciences Building'),
('English Literature', 'Humanities Building'),
('History', 'Humanities Building'),
('Psychology', 'Social Sciences Building'),
('Economics', 'Business Building'),
('Mechanical Engineering', 'Engineering Complex');


--The students are distributed across departments with 10 students in each department.
--They have have also been distributed across enrolment years:
--20 students in 2021, 20 in 2022, and 60 in 2023 to portray a growing student population
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone, enrollment_date, department_id) VALUES
('Emma', 'Johnson', '2000-03-15', 'emma.johnson@university.edu', '555-0101', '2021-09-01', 1),
('Noah', 'Smith', '2001-07-22', 'noah.smith@university.edu', '555-0102', '2021-09-01', 2),
('Olivia', 'Williams', '2000-11-30', 'olivia.williams@university.edu', '555-0103', '2021-09-01', 3),
('Liam', 'Brown', '2002-01-14', 'liam.brown@university.edu', '555-0104', '2021-09-01', 4),
('Ava', 'Jones', '2001-05-09', 'ava.jones@university.edu', '555-0105', '2021-09-01', 5),
('William', 'Garcia', '2000-09-18', 'william.garcia@university.edu', '555-0106', '2021-09-01', 6),
('Sophia', 'Miller', '2002-02-25', 'sophia.miller@university.edu', '555-0107', '2021-09-01', 7),
('Mason', 'Davis', '2001-12-05', 'mason.davis@university.edu', '555-0108', '2021-09-01', 8),
('Isabella', 'Rodriguez', '2000-08-12', 'isabella.rodriguez@university.edu', '555-0109', '2021-09-01', 9),
('James', 'Martinez', '2002-04-30', 'james.martinez@university.edu', '555-0110', '2021-09-01', 10),
('Mia', 'Hernandez', '2001-06-17', 'mia.hernandez@university.edu', '555-0111', '2021-09-01', 1),
('Benjamin', 'Lopez', '2000-10-23', 'benjamin.lopez@university.edu', '555-0112', '2021-09-01', 2),
('Charlotte', 'Gonzalez', '2002-03-08', 'charlotte.gonzalez@university.edu', '555-0113', '2021-09-01', 3),
('Elijah', 'Wilson', '2001-01-19', 'elijah.wilson@university.edu', '555-0114', '2021-09-01', 4),
('Amelia', 'Anderson', '2000-07-04', 'amelia.anderson@university.edu', '555-0115', '2021-09-01', 5),
('Lucas', 'Thomas', '2002-05-27', 'lucas.thomas@university.edu', '555-0116', '2021-09-01', 6),
('Harper', 'Taylor', '2001-11-11', 'harper.taylor@university.edu', '555-0117', '2021-09-01', 7),
('Alexander', 'Moore', '2000-02-28', 'alexander.moore@university.edu', '555-0118', '2021-09-01', 8),
('Evelyn', 'Jackson', '2002-08-15', 'evelyn.jackson@university.edu', '555-0119', '2021-09-01', 9),
('Michael', 'Martin', '2001-04-02', 'michael.martin@university.edu', '555-0120', '2021-09-01', 10),
('Ethan', 'Lee', '2000-12-09', 'ethan.lee@university.edu', '555-0121', '2022-09-01', 1),
('Abigail', 'Perez', '2003-06-24', 'abigail.perez@university.edu', '555-0122', '2022-09-01', 2),
('Daniel', 'Thompson', '2002-10-31', 'daniel.thompson@university.edu', '555-0123', '2022-09-01', 3),
('Emily', 'White', '2001-02-14', 'emily.white@university.edu', '555-0124', '2022-09-01', 4),
('Jacob', 'Harris', '2003-08-07', 'jacob.harris@university.edu', '555-0125', '2022-09-01', 5),
('Elizabeth', 'Sanchez', '2002-01-22', 'elizabeth.sanchez@university.edu', '555-0126', '2022-09-01', 6),
('Logan', 'Clark', '2001-05-11', 'logan.clark@university.edu', '555-0127', '2022-09-01', 7),
('Sofia', 'Ramirez', '2003-03-26', 'sofia.ramirez@university.edu', '555-0128', '2022-09-01', 8),
('Jackson', 'Lewis', '2002-07-13', 'jackson.lewis@university.edu', '555-0129', '2022-09-01', 9),
('Avery', 'Robinson', '2001-09-28', 'avery.robinson@university.edu', '555-0130', '2022-09-01', 10),
('Sebastian', 'Walker', '2003-04-05', 'sebastian.walker@university.edu', '555-0131', '2022-09-01', 1),
('Ella', 'Young', '2002-11-20', 'ella.young@university.edu', '555-0132', '2022-09-01', 2),
('Aiden', 'Allen', '2001-03-17', 'aiden.allen@university.edu', '555-0133', '2022-09-01', 3),
('Scarlett', 'King', '2003-09-02', 'scarlett.king@university.edu', '555-0134', '2022-09-01', 4),
('Matthew', 'Wright', '2002-12-15', 'matthew.wright@university.edu', '555-0135', '2022-09-01', 5),
('Grace', 'Scott', '2001-06-30', 'grace.scott@university.edu', '555-0136', '2022-09-01', 6),
('Samuel', 'Torres', '2003-01-25', 'samuel.torres@university.edu', '555-0137', '2022-09-01', 7),
('Chloe', 'Nguyen', '2002-05-08', 'chloe.nguyen@university.edu', '555-0138', '2022-09-01', 8),
('David', 'Hill', '2001-10-23', 'david.hill@university.edu', '555-0139', '2022-09-01', 9),
('Victoria', 'Flores', '2003-07-16', 'victoria.flores@university.edu', '555-0140', '2022-09-01', 10),
('Joseph', 'Green', '2002-02-07', 'joseph.green@university.edu', '555-0141', '2023-09-01', 1),
('Riley', 'Adams', '2004-08-22', 'riley.adams@university.edu', '555-0142', '2023-09-01', 2),
('Carter', 'Nelson', '2003-12-09', 'carter.nelson@university.edu', '555-0143', '2023-09-01', 3),
('Luna', 'Baker', '2002-04-14', 'luna.baker@university.edu', '555-0144', '2023-09-01', 4),
('Owen', 'Hall', '2004-10-29', 'owen.hall@university.edu', '555-0145', '2023-09-01', 5),
('Zoey', 'Rivera', '2003-05-06', 'zoey.rivera@university.edu', '555-0146', '2023-09-01', 6),
('Wyatt', 'Campbell', '2002-09-21', 'wyatt.campbell@university.edu', '555-0147', '2023-09-01', 7),
('Lily', 'Mitchell', '2004-03-12', 'lily.mitchell@university.edu', '555-0148', '2023-09-01', 8),
('John', 'Carter', '2003-11-27', 'john.carter@university.edu', '555-0149', '2023-09-01', 9),
('Hannah', 'Roberts', '2002-06-03', 'hannah.roberts@university.edu', '555-0150', '2023-09-01', 10),
('Jack', 'Gomez', '2004-01-18', 'jack.gomez@university.edu', '555-0151', '2023-09-01', 1),
('Lillian', 'Phillips', '2003-08-05', 'lillian.phillips@university.edu', '555-0152', '2023-09-01', 2),
('Luke', 'Evans', '2002-12-20', 'luke.evans@university.edu', '555-0153', '2023-09-01', 3),
('Addison', 'Turner', '2004-05-15', 'addison.turner@university.edu', '555-0154', '2023-09-01', 4),
('Jayden', 'Diaz', '2003-10-30', 'jayden.diaz@university.edu', '555-0155', '2023-09-01', 5),
('Layla', 'Parker', '2002-07-07', 'layla.parker@university.edu', '555-0156', '2023-09-01', 6),
('Dylan', 'Cruz', '2004-02-22', 'dylan.cruz@university.edu', '555-0157', '2023-09-01', 7),
('Natalie', 'Edwards', '2003-09-14', 'natalie.edwards@university.edu', '555-0158', '2023-09-01', 8),
('Grayson', 'Collins', '2002-04-29', 'grayson.collins@university.edu', '555-0159', '2023-09-01', 9),
('Aubrey', 'Reyes', '2004-11-13', 'aubrey.reyes@university.edu', '555-0160', '2023-09-01', 10),
('Isaac', 'Stewart', '2003-06-28', 'isaac.stewart@university.edu', '555-0161', '2023-09-01', 1),
('Bella', 'Morris', '2002-01-11', 'bella.morris@university.edu', '555-0162', '2023-09-01', 2),
('Gabriel', 'Morales', '2004-08-26', 'gabriel.morales@university.edu', '555-0163', '2023-09-01', 3),
('Stella', 'Murphy', '2003-03-19', 'stella.murphy@university.edu', '555-0164', '2023-09-01', 4),
('Julian', 'Cook', '2002-10-04', 'julian.cook@university.edu', '555-0165', '2023-09-01', 5),
('Savannah', 'Rogers', '2004-05-21', 'savannah.rogers@university.edu', '555-0166', '2023-09-01', 6),
('Levi', 'Gutierrez', '2003-12-06', 'levi.gutierrez@university.edu', '555-0167', '2023-09-01', 7),
('Ellie', 'Ortiz', '2002-07-23', 'ellie.ortiz@university.edu', '555-0168', '2023-09-01', 8),
('Jonathan', 'Morgan', '2004-02-15', 'jonathan.morgan@university.edu', '555-0169', '2023-09-01', 9),
('Nora', 'Cooper', '2003-09-30', 'nora.cooper@university.edu', '555-0170', '2023-09-01', 10),
('Lincoln', 'Peterson', '2002-04-13', 'lincoln.peterson@university.edu', '555-0171', '2023-09-01', 1),
('Hazel', 'Bailey', '2004-11-28', 'hazel.bailey@university.edu', '555-0172', '2023-09-01', 2),
('Caleb', 'Reed', '2003-06-11', 'caleb.reed@university.edu', '555-0173', '2023-09-01', 3),
('Violet', 'Kelly', '2002-01-26', 'violet.kelly@university.edu', '555-0174', '2023-09-01', 4),
('Ryan', 'Howard', '2004-08-09', 'ryan.howard@university.edu', '555-0175', '2023-09-01', 5),
('Aurora', 'Ward', '2003-03-24', 'aurora.ward@university.edu', '555-0176', '2023-09-01', 6),
('Nathan', 'Cox', '2002-10-07', 'nathan.cox@university.edu', '555-0177', '2023-09-01', 7),
('Audrey', 'Diaz', '2004-05-22', 'audrey.diaz@university.edu', '555-0178', '2023-09-01', 8),
('Thomas', 'Richardson', '2003-12-05', 'thomas.richardson@university.edu', '555-0179', '2023-09-01', 9),
('Claire', 'Wood', '2002-07-20', 'claire.wood@university.edu', '555-0180', '2023-09-01', 10),
('Hunter', 'Watson', '2004-02-12', 'hunter.watson@university.edu', '555-0181', '2023-09-01', 1),
('Skylar', 'Brooks', '2003-09-27', 'skylar.brooks@university.edu', '555-0182', '2023-09-01', 2),
('Eli', 'Bennett', '2002-04-10', 'eli.bennett@university.edu', '555-0183', '2023-09-01', 3),
('Paisley', 'Gray', '2004-11-25', 'paisley.gray@university.edu', '555-0184', '2023-09-01', 4),
('Christian', 'James', '2003-06-08', 'christian.james@university.edu', '555-0185', '2023-09-01', 5),
('Aaliyah', 'Reyes', '2002-01-21', 'aaliyah.reyes@university.edu', '555-0186', '2023-09-01', 6),
('Landon', 'Cruz', '2004-08-06', 'landon.cruz@university.edu', '555-0187', '2023-09-01', 7),
('Elliana', 'Hughes', '2003-03-19', 'elliana.hughes@university.edu', '555-0188', '2023-09-01', 8),
('Adrian', 'Price', '2002-10-02', 'adrian.price@university.edu', '555-0189', '2023-09-01', 9),
('Nova', 'Myers', '2004-05-17', 'nova.myers@university.edu', '555-0190', '2023-09-01', 10),
('Connor', 'Long', '2003-12-30', 'connor.long@university.edu', '555-0191', '2023-09-01', 1),
('Emilia', 'Foster', '2002-08-15', 'emilia.foster@university.edu', '555-0192', '2023-09-01', 2),
('Cameron', 'Sanders', '2004-03-28', 'cameron.sanders@university.edu', '555-0193', '2023-09-01', 3),
('Kennedy', 'Ross', '2003-10-11', 'kennedy.ross@university.edu', '555-0194', '2023-09-01', 4),
('Eva', 'Morales', '2002-05-26', 'eva.morales@university.edu', '555-0195', '2023-09-01', 5),
('Nicholas', 'Powell', '2004-01-09', 'nicholas.powell@university.edu', '555-0196', '2023-09-01', 6),
('Sarah', 'Sullivan', '2003-08-24', 'sarah.sullivan@university.edu', '555-0197', '2023-09-01', 7),
('Aaron', 'Russell', '2002-03-07', 'aaron.russell@university.edu', '555-0198', '2023-09-01', 8),
('Madelyn', 'Ortiz', '2004-10-22', 'madelyn.ortiz@university.edu', '555-0199', '2023-09-01', 9),
('Tyler', 'Jenkins', '2003-05-05', 'tyler.jenkins@university.edu', '555-0200', '2023-09-01', 10);


--Instructors have been distributed evenly across all 10 departments (2 per department)
--The abreviations are the office numbers that correspond to the building codes
--TB(Technical Building), SH(Science Hall), RB (Research Buildin), LSB(Life Research Building)
--HB (Humanities Building), SSB(Social Sciences Building), BB(Buisiness Building), and EC(Engineering Complex)

INSERT INTO Instructors (first_name, last_name, email, office_number, department_id) VALUES
('Robert', 'Johnson', 'rjohnson@nairobi.edu', 'TB-101', 1),
('Jennifer', 'Williams', 'jwilliams@nairobi.edu', 'TB-102', 1),
('Michael', 'Brown', 'mbrown@nairobi.edu', 'SH-201', 2),
('Sarah', 'Davis', 'sdavis@nairobi.edu', 'SH-202', 2),
('David', 'Miller', 'dmiller@nairobi.edu', 'SH-301', 3),
('Lisa', 'Wilson', 'lwilson@nairobi.edu', 'SH-302', 3),
('James', 'Moore', 'jmoore@nairobi.edu', 'RB-101', 4),
('Karen', 'Taylor', 'ktaylor@nairobi.edu', 'RB-102', 4),
('Richard', 'Anderson', 'randerson@nairobi.edu', 'LSB-201', 5),
('Nancy', 'Thomas', 'nthomas@nairobi.edu', 'LSB-202', 5),
('Charles', 'Jackson', 'cjackson@nairobi.edu', 'HB-301', 6),
('Patricia', 'White', 'pwhite@nairobi.edu', 'HB-302', 6),
('Thomas', 'Harris', 'tharris@nairobi.edu', 'HB-401', 7),
('Susan', 'Martin', 'smartin@nairobi.edu', 'HB-402', 7),
('Christopher', 'Thompson', 'cthompson@nairobi.edu', 'SSB-101', 8),
('Betty', 'Garcia', 'bgarcia@nairobi.edu', 'SSB-102', 8),
('Daniel', 'Martinez', 'dmartinez@nairobi.edu', 'BB-201', 9),
('Margaret', 'Robinson', 'mrobinson@nairobi.edu', 'BB-202', 9),
('Paul', 'Clark', 'pclark@nairobi.edu', 'EC-301', 10),
('Dorothy', 'Rodriguez', 'drodriguez@nairobi.edu', 'EC-302', 10);

--We have 10 departments and 20 instructors (2 per department). We have assigned coures to instructors in their respective departments
--Each department offers 5 courses, hence, we have a total of 50 courses
--The courses are distributed between the two instructors in each department, with some instructors teaching multiple courses


INSERT INTO Courses (course_code, course_name, credits, instructor_id, department_id) VALUES
-- Computer Science Courses (Department 1)
('CS101', 'Introduction to Programming', 3.0, 1, 1),
('CS201', 'Data Structures and Algorithms', 4.0, 1, 1),
('CS301', 'Database Systems', 4.0, 2, 1),
('CS401', 'Artificial Intelligence', 3.5, 2, 1),
('CS202', 'Computer Networks', 3.5, 1, 1),

-- Mathematics Courses (Department 2)
('MATH101', 'Calculus I', 4.0, 3, 2),
('MATH102', 'Calculus II', 4.0, 3, 2),
('MATH201', 'Linear Algebra', 3.0, 4, 2),
('MATH301', 'Differential Equations', 3.5, 4, 2),
('MATH401', 'Advanced Statistics', 3.0, 3, 2),

-- Physics Courses (Department 3)
('PHYS101', 'General Physics I', 4.0, 5, 3),
('PHYS102', 'General Physics II', 4.0, 5, 3),
('PHYS201', 'Modern Physics', 3.5, 6, 3),
('PHYS301', 'Quantum Mechanics', 4.0, 6, 3),
('PHYS202', 'Thermodynamics', 3.0, 5, 3),

-- Chemistry Courses (Department 4)
('CHEM101', 'General Chemistry I', 4.0, 7, 4),
('CHEM102', 'General Chemistry II', 4.0, 7, 4),
('CHEM201', 'Organic Chemistry', 4.0, 8, 4),
('CHEM301', 'Biochemistry', 3.5, 8, 4),
('CHEM401', 'Analytical Chemistry', 3.0, 7, 4),

-- Biology Courses (Department 5)
('BIO101', 'Introduction to Biology', 4.0, 9, 5),
('BIO201', 'Cell Biology', 4.0, 9, 5),
('BIO301', 'Genetics', 3.5, 10, 5),
('BIO401', 'Evolutionary Biology', 3.0, 10, 5),
('BIO202', 'Microbiology', 3.5, 9, 5),

-- English Literature Courses (Department 6)
('ENG101', 'Introduction to Literature', 3.0, 11, 6),
('ENG201', 'British Literature', 3.0, 11, 6),
('ENG301', 'American Literature', 3.0, 12, 6),
('ENG401', 'Shakespeare Studies', 3.5, 12, 6),
('ENG202', 'Creative Writing', 3.0, 11, 6),

-- History Courses (Department 7)
('HIST101', 'World History I', 3.0, 13, 7),
('HIST102', 'World History II', 3.0, 13, 7),
('HIST201', 'American History', 3.0, 14, 7),
('HIST301', 'European History', 3.5, 14, 7),
('HIST401', 'Asian History', 3.0, 13, 7),

-- Psychology Courses (Department 8)
('PSY101', 'Introduction to Psychology', 3.0, 15, 8),
('PSY201', 'Developmental Psychology', 3.0, 15, 8),
('PSY301', 'Abnormal Psychology', 3.5, 16, 8),
('PSY401', 'Cognitive Psychology', 3.5, 16, 8),
('PSY202', 'Social Psychology', 3.0, 15, 8),

-- Economics Courses (Department 9)
('ECON101', 'Principles of Economics', 3.0, 17, 9),
('ECON201', 'Microeconomics', 3.5, 17, 9),
('ECON301', 'Macroeconomics', 3.5, 18, 9),
('ECON401', 'Econometrics', 4.0, 18, 9),
('ECON202', 'International Economics', 3.0, 17, 9),

-- Mechanical Engineering Courses (Department 10)
('ME101', 'Introduction to Engineering', 3.0, 19, 10),
('ME201', 'Statics and Dynamics', 4.0, 19, 10),
('ME301', 'Thermodynamics', 4.0, 20, 10),
('ME401', 'Machine Design', 4.0, 20, 10),
('ME202', 'Materials Science', 3.5, 19, 10)

