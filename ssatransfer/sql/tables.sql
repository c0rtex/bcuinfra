CREATE TABLE screening_submission 
(
	submission_id INT IDENTITY(1,1) NOT NULL,
	screening_id int NOT NULL,
	reentry_number int,
    submission_status varchar(10),
    submission_result text,  
	post_start_time datetime NOT NULL,
	post_finish_time datetime,
        PRIMARY KEY (submission_id) 	
) 