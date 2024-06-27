-- Code to create SQL Views for visualization
-- Author: Kevin Baum
-- Updated: 06/24/2024

CREATE VIEW calls_per_zipCode AS
	SELECT 
		YEAR(SC.incident_date_time) AS IncidentYear, 
		WEEK(SC.incident_date_time)+1 AS IncidentWeek, 
		ZC.Zipcode, 
		COUNT(SC.incident_num) AS NumberOfCalls 
	FROM 
		service_calls SC 
	INNER JOIN 
		zipcodes ZC
	ON 
		SC.incident_num = ZC.incident_num
	GROUP BY 
		YEAR(SC.incident_date_time),  
		WEEK(SC.incident_date_time)+1, 
		ZC.`Zipcode`;


CREATE VIEW calls_per_year_per_type_disposition_beat AS
	SELECT 
		YEAR(SC.incident_date_time) AS IncidentYear,
		WEEK(SC.incident_date_time)+1 AS IncidentWeek,
		DATE(SC.incident_date_time) AS IncidentDate,
		CT.description AS ReASonForCall,
		D.description AS Disposition,
		B.neighborhood AS Beat, COUNT(*) AS NumberOfCalls
	FROM 
		service_calls SC
	INNER JOIN 
		call_types CT
	ON 
		SC.call_type = CT.call_type
	INNER JOIN 
		dispositions D
	ON 
		SC.dispo_code = D.dispo_code
	INNER JOIN 
		beats B 
	ON 
		SC.beat = B.beat
	GROUP BY 
		YEAR(SC.incident_date_time),
		WEEK(SC.incident_date_time)+1,
		DATE(SC.incident_date_time), 
		CT.description, 
		D.description, 
		B.neighborhood; 

-- SQLBook: Code
  
CREATE VIEW call_type_per_zipcode AS
        SELECT 
			YEAR(SC.incident_date_time) AS Incident_Year, 
			WEEK(SC.incident_date_time)+1 AS IncidentWeek,
			ZC.`Zipcode`, COUNT(DISTINCT SC.CALL_TYPE) AS CallTypes 
        FROM 
			service_calls SC 
		INNER JOIN 
			zipcodes ZC
        ON 
			SC.incident_num = ZC.incident_num
        GROUP BY 
			YEAR(SC.incident_date_time),
			WEEK(SC.incident_date_time)+1, 
            ZC.`Zipcode`;
  
CREATE VIEW call_per_beat AS
	SELECT 
		YEAR(SC.incident_date_time) AS Incident_Year,
		WEEK(SC.incident_date_time)+1 AS IncidentWeek,
		B.neighborhood AS Beat, 
        COUNT(DISTINCT SC.incident_num) AS NumberOfCalls 
	FROM 
		service_calls SC 
	INNER JOIN 
		beats B
	ON 
		SC.beat = B.beat
	GROUP BY 
		YEAR(SC.incident_date_time), 
		WEEK(SC.incident_date_time)+1,
		B.neighborhood;

CREATE VIEW calls_calltype AS
	SELECT 
		YEAR(SC.incident_date_time) AS Incident_Year, 
		WEEK(SC.incident_date_time)+1 AS IncidentWeek,
		CT.description AS CallType, COUNT(DISTINCT SC.incident_num) AS NumberOfCalls 
	FROM 
		service_calls SC 
	INNER JOIN 
		call_types CT
	ON 
		SC.call_type = CT.call_type
	GROUP BY 
		YEAR(SC.INCIDENT_DATE_TIME), 
		WEEK(SC.incident_date_time)+1,
		CT.description;


CREATE VIEW calls_dispo AS
	SELECT 
		YEAR(SC.incident_date_time) AS Incident_Year,
		WEEK(SC.incident_date_time)+1 AS IncidentWeek,
		D.description AS Disposition, 
        COUNT(DISTINCT SC.incident_num) AS NumberOfCalls 
	FROM 
		service_calls SC 
	INNER JOIN 
		dispositions D
	ON 
		SC.dispo_code = D.dispo_code
	GROUP BY 
		YEAR(SC.INCIDENT_DATE_TIME), 
		WEEK(SC.incident_date_time)+1,
		D.description;

CREATE VIEW calls_per_zipCode_lat_long AS 
	SELECT 
		YEAR(SC.incident_date_time) AS IncidentYear, 
		WEEK(SC.incident_date_time)+1 AS IncidentWeek,
		ZC.Zipcode, 
        GL.lat, 
        GL.lng, 
        COUNT(*) AS NumberOfCalls 
	FROM 
		service_calls SC 
	INNER JOIN 
		zipcodes ZC
	ON 
		SC.incident_num = ZC.incident_num
	INNER JOIN 
		geolocations GL
	ON 
		SC.incident_num = GL.incident_num
	GROUP BY 
		YEAR(SC.incident_date_time),
		WEEK(SC.incident_date_time)+1,
		ZC.`Zipcode`, 
        GL.lat, 
        GL.lng;
