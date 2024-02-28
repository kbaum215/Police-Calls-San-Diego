-- SQLBook: Code
-- Active: 1676578331006@@sdpd.chck20ykciaw.us-west-2.rds.amazonaws.com@3306@sdpd
drop view calls_per_zipCode;
drop view call_type_per_zipcode;
drop view call_per_beat;
drop view calls_callyype;
drop view calls_dispo;
drop view calls_per_day_reason_disposition_beat;
drop view calls_per_zipCode_lat_long;


-- SQLBook: Code
-- Active: 1677446070425@@sdpd.chck20ykciaw.us-west-2.rds.amazonaws.com@3306@sdpd
create view calls_per_zipCode as
SELECT YEAR(SC.incident_date_time) as IncidentYear, 
        WEEK(SC.incident_date_time)+1 as IncidentWeek, ZC.Zipcode, COUNT(*) AS NumberOfCalls 
        FROM service_calls SC INNER JOIN zipcodes ZC
        ON SC.INCIDENT_NUM = ZC.INCIDENT_NUM
        GROUP BY YEAR(SC.incident_date_time),  WEEK(SC.incident_date_time), ZC.`Zipcode`;
-- SQLBook: Code

--Views--initiate dictionary --Add VIEWS
CREATE VIEW calls_per_year_per_type_disposition_beat AS
        SELECT YEAR(SC.incident_date_time) AS IncidentYear,
        WEEK(SC.incident_date_time)+1 as IncidentWeek,
        DATE(SC.incident_date_time) AS IncidentDate,
        CT.description AS ReasonForCall,
        D.description AS Disposition,
        B.neighborhood AS Beat, COUNT(*) AS NumberOfCalls
        FROM service_calls SC
        INNER JOIN call_types CT
            ON SC.call_type = CT.call_type
        INNER JOIN dispositions D
            ON SC.dispo_code = D.dispo_code
        INNER JOIN beats B ON SC.beat = B.beat
        GROUP BY YEAR(SC.incident_date_time),
        WEEK(SC.incident_date_time) as IncidentWeek,
        DATE(SC.incident_date_time), CT.description, D.description, B.neighborhood; 

-- SQLBook: Code
  
CREATE VIEW call_type_per_zipcode AS
        SELECT YEAR(SC.incident_date_time) AS Incident_Year, 
        WEEK(SC.incident_date_time)+1 as IncidentWeek,
        ZC.`Zipcode`, COUNT(DISTINCT SC.CALL_TYPE) AS CallTypes 
        FROM service_calls SC INNER JOIN zipcodes ZC
        ON SC.incident_num = ZC.incident_num
        GROUP BY YEAR(SC.incident_date_time),
        WEEK(SC.incident_date_time) as IncidentWeek, ZC.`Zipcode`;
-- SQLBook: Code
  
CREATE VIEW call_per_beat AS
        SELECT YEAR(SC.incident_date_time) AS Incident_Year,
        WEEK(SC.incident_date_time)+1 as IncidentWeek,
        B.neighborhood AS Beat, COUNT(DISTINCT SC.incident_num) AS NumberOfCalls 
        FROM service_calls SC INNER JOIN beats B
        ON SC.beat = B.beat
        GROUP BY YEAR(SC.incident_date_time), 
        WEEK(SC.incident_date_time) as IncidentWeek,
        B.neighborhood;
-- SQLBook: Code

CREATE VIEW calls_calltype AS
        SELECT YEAR(SC.incident_date_time) AS Incident_Year, 
        WEEK(SC.incident_date_time)+1 as IncidentWeek,
        CT.description AS CallType, COUNT(DISTINCT SC.incident_num) AS NumberOfCalls 
        FROM service_calls SC INNER JOIN call_types CT
        ON SC.call_type = CT.call_type
        GROUP BY YEAR(SC.INCIDENT_DATE_TIME), 
        WEEK(SC.incident_date_time) as IncidentWeek,
        CT.description;


-- SQLBook: Code

CREATE VIEW calls_dispo AS
        SELECT YEAR(SC.incident_date_time) AS Incident_Year,
        WEEK(SC.incident_date_time)+1 as IncidentWeek,
        D.description AS Disposition, COUNT(DISTINCT SC.incident_num) AS NumberOfCalls 
        FROM service_calls SC INNER JOIN dispositions D
        ON SC.dispo_code = D.dispo_code
        GROUP BY YEAR(SC.INCIDENT_DATE_TIME), 
        WEEK(SC.incident_date_time) as IncidentWeek,
        D.description;
-- SQLBook: Code

CREATE VIEW calls_per_zipCode_lat_long as 
        SELECT YEAR(SC.incident_date_time) as IncidentYear, 
        WEEK(SC.incident_date_time)+1 as IncidentWeek,
        ZC.Zipcode, GL.lat, GL.lng, COUNT(*) AS NumberOfCalls 
        FROM service_calls SC INNER JOIN zipcodes ZC
        ON SC.incident_num = ZC.incident_num
        INNER JOIN geolocations GL
        ON SC.incident_num = GL.incident_num
        GROUP BY YEAR(SC.incident_date_time),
        WEEK(SC.incident_date_time) as IncidentWeek,
        ZC.`Zipcode`, GL.lat, GL.lng;
