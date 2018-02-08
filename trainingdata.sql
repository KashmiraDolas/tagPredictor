CREATE TABLE trainingdata
(
    postid INTEGER,
    owneruserid INTEGER,
    reputationatpostcreation INTEGER,
    title VARCHAR,
    bodymarkdown VARCHAR,
    tag1 VARCHAR,
    tag2 VARCHAR,
    tag3 VARCHAR,
    tag4 VARCHAR,
    tag5 VARCHAR,
    PRIMARY KEY (postid)
);

COPY trainingdata
FROM '/Users/CASH/Desktop/TrainingSet.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM trainingdata;