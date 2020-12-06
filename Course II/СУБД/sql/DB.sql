DROP TABLE student_course_detail;
DROP TABLE exam_result;
DROP TABLE exam;
DROP TABLE exam_type;
DROP TABLE faculty_course_detail;
DROP TABLE faculty_login_detail;
DROP TABLE student_attendance;
DROP TABLE student;
DROP TABLE parent_information;
DROP TABLE full_time;
DROP TABLE part_time;
DROP TABLE faculty;
DROP TABLE course;
DROP TABLE department;
DROP TABLE "ONLINE";
DROP TABLE seated;
DROP TABLE academic_session;

CREATE TABLE academic_session (
    id    NUMBER NOT NULL,
    name  VARCHAR2(400) NOT NULL,
    CONSTRAINT academic_session_pk PRIMARY KEY ( id )
);

CREATE TABLE seated (
    building     VARCHAR2(400) NOT NULL,
    room         VARCHAR2(400) NOT NULL,
    "DateTime"  TIMESTAMP NOT NULL,
    CONSTRAINT seated_pk PRIMARY KEY ( "DateTime", building, room )
);

CREATE TABLE "ONLINE" (
    logon_id  NUMBER NOT NULL,
    password  VARCHAR2(400) NOT NULL,
    CONSTRAINT online_pk PRIMARY KEY ( logon_id )
);

CREATE TABLE department (
    id    NUMBER NOT NULL,
    name  VARCHAR2(400) NOT NULL,
    head  VARCHAR2(400) NOT NULL,
    CONSTRAINT department_pk PRIMARY KEY ( id )
);

CREATE TABLE course (
    id                   NUMBER NOT NULL,
    name                 VARCHAR2(400) NOT NULL,
    department_id        NUMBER NOT NULL,
    academic_session_id  NUMBER NOT NULL,
    online_logon_id      NUMBER,
    seated_building      VARCHAR2(400),
    seated_room          VARCHAR2(400),
    SEATED_DateTime   TIMESTAMP,
    id1                  NUMBER NOT NULL,
    id2                  NUMBER NOT NULL,
    building             VARCHAR2(400) NOT NULL,
    room                 VARCHAR2(400) NOT NULL,
    CONSTRAINT course_pk PRIMARY KEY ( id ),
    CONSTRAINT arc_1 CHECK ( ( ( online_logon_id IS NOT NULL ) AND ( SEATED_DateTime IS NULL ) AND ( seated_building IS NULL ) AND ( seated_room IS NULL ) ) OR ( ( SEATED_DateTime IS NOT NULL ) AND ( seated_building IS NOT NULL ) AND ( seated_room IS NOT NULL ) AND ( online_logon_id IS NULL ) ) ),
    CONSTRAINT course_academic_session_fk FOREIGN KEY ( academic_session_id ) REFERENCES academic_session ( id ),
    CONSTRAINT course_department_fk FOREIGN KEY ( department_id ) REFERENCES department ( id ),
    CONSTRAINT course_online_fk FOREIGN KEY ( online_logon_id ) REFERENCES "ONLINE" ( logon_id ),
    CONSTRAINT course_seated_fk FOREIGN KEY ( SEATED_DateTime, seated_building, seated_room ) REFERENCES seated ( "DateTime", building, room )
);

CREATE TABLE faculty (
    id             NUMBER NOT NULL,
    first_name     VARCHAR2(400) NOT NULL,
    last_name      VARCHAR2(400) NOT NULL,
    email          VARCHAR2(400) NOT NULL,
    department_id  NUMBER NOT NULL,
    id1            NUMBER NOT NULL,
    CONSTRAINT faculty_pk PRIMARY KEY ( id ),
    CONSTRAINT faculty_department_fk FOREIGN KEY ( department_id ) REFERENCES department ( id )
);

CREATE TABLE full_time (
    id              NUMBER NOT NULL,
    salary          NUMBER NOT NULL,
    insurance_plan  VARCHAR2(400) NOT NULL,
    CONSTRAINT full_time_pk PRIMARY KEY ( id ),
    CONSTRAINT full_time_faculty_fk FOREIGN KEY ( id ) REFERENCES faculty ( id )
);

CREATE TABLE part_time (
    id           NUMBER NOT NULL,
    hourly_rate  NUMBER NOT NULL,
    CONSTRAINT part_time_pk PRIMARY KEY ( id ),
    CONSTRAINT part_time_faculty_fk FOREIGN KEY ( id ) REFERENCES faculty ( id )

);

CREATE TABLE parent_information (
    id                   NUMBER NOT NULL,
    parent_1_first_name  VARCHAR2(400) NOT NULL,
    parent_1_last_name   VARCHAR2(400) NOT NULL,
    parent_2_first_name  VARCHAR2(400) NOT NULL,
    parent_2_last_name   VARCHAR2(400) NOT NULL,
    CONSTRAINT parent_information_pk PRIMARY KEY ( id )
);

CREATE TABLE student (
    id                     NUMBER NOT NULL,
    first_name             VARCHAR2(400) NOT NULL,
    last_name              VARCHAR2(400) NOT NULL,
    registration_year      TIMESTAMP NOT NULL,
    email                  VARCHAR2(400) NOT NULL,
    parent_information_id  NUMBER,
    id1                    NUMBER,
    CONSTRAINT student_pk PRIMARY KEY ( id ),
    CONSTRAINT student_parent_information_fk FOREIGN KEY ( parent_information_id ) REFERENCES parent_information ( id )
);

CREATE TABLE student_attendance (
    number_of_working_days  NUMBER NOT NULL,
    number_of_days_off      NUMBER NOT NULL,
    eligibility_for_exam    NUMBER,
    student_id              NUMBER NOT NULL,
    academic_session_id     NUMBER NOT NULL,
    id                      NUMBER NOT NULL,
    id1                     NUMBER NOT NULL,
    CONSTRAINT student_attendance_pk PRIMARY KEY ( id, id1 ),
    CONSTRAINT student_aa_session_fk FOREIGN KEY ( academic_session_id ) REFERENCES academic_session ( id ),
    CONSTRAINT student_attendance_student_fk FOREIGN KEY ( student_id ) REFERENCES student ( id )

);

CREATE TABLE faculty_login_detail (
    login_datetime  TIMESTAMP NOT NULL,
    faculty_id      NUMBER NOT NULL,
    CONSTRAINT faculty_login_detail_pk PRIMARY KEY ( faculty_id ),
    CONSTRAINT faculty_ldetail_faculty_fk FOREIGN KEY ( faculty_id ) REFERENCES faculty ( id )
);

CREATE TABLE faculty_course_detail (
    contact_hours  VARCHAR2(400) NOT NULL,
    course_id      NUMBER NOT NULL,
    faculty_id     NUMBER NOT NULL,
    CONSTRAINT faculty_course_detail_pk PRIMARY KEY ( course_id, faculty_id ),
    CONSTRAINT faculty_cdetail_course_fk FOREIGN KEY ( course_id ) REFERENCES course ( id ),
    CONSTRAINT faculty_cdetail_faculty_fk FOREIGN KEY ( faculty_id ) REFERENCES faculty ( id )
);

CREATE TABLE exam_type (
    type         NUMBER NOT NULL,
    name         VARCHAR2(400) NOT NULL,
    description  VARCHAR2(400),
    CONSTRAINT exam_type_pk PRIMARY KEY ( type )
);


CREATE TABLE exam (
    id              NUMBER NOT NULL,
    start_date      TIMESTAMP,
    course_id       NUMBER NOT NULL,
    exam_type_type  NUMBER NOT NULL,
    CONSTRAINT exam_pk PRIMARY KEY ( id ),
    CONSTRAINT exam_course_fk FOREIGN KEY ( course_id ) REFERENCES course ( id ),
    CONSTRAINT exam_exam_type_fk FOREIGN KEY ( exam_type_type ) REFERENCES exam_type ( type )
);

CREATE TABLE exam_result (
    grade       NUMBER NOT NULL,
    course_id   NUMBER NOT NULL,
    student_id  NUMBER NOT NULL,
    exam_id     NUMBER NOT NULL,
    id          NUMBER NOT NULL,
    CONSTRAINT exam_result_pk PRIMARY KEY ( course_id, exam_id, id ),
    CONSTRAINT exam_result_course_fk FOREIGN KEY ( course_id ) REFERENCES course ( id ),
    CONSTRAINT exam_result_exam_fk FOREIGN KEY ( exam_id ) REFERENCES exam ( id ),
    CONSTRAINT exam_result_student_fk FOREIGN KEY ( student_id ) REFERENCES student ( id )
);

CREATE TABLE student_course_detail (
    grade       NUMBER NOT NULL,
    course_id   NUMBER NOT NULL,
    student_id  NUMBER NOT NULL,
    id          NUMBER NOT NULL,
    CONSTRAINT student_course_detail_pk PRIMARY KEY ( course_id, id ),
    CONSTRAINT student_cdetail_course_fk FOREIGN KEY ( course_id ) REFERENCES course ( id ),
    CONSTRAINT student_cdetail_student_fk FOREIGN KEY ( student_id ) REFERENCES student ( id )
);

CREATE OR REPLACE TRIGGER fkntm_exam_result BEFORE
    UPDATE OF student_id ON exam_result
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table EXAM_RESULT is violated');
END;