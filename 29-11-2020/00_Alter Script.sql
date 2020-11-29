
DROP Index Idx_Project_ManualProjectCode ON Project;

ALTER TABLE Project ALTER COLUMN ManualProjectCode varchar(15);
CREATE INDEX Idx_Project_ManualProjectCode
ON Project ([ManualProjectCode]);
ALTER TABLE Project ALTER COLUMN IFSProjectCode varchar(15);
--ADD Column filepath to ScenarioFiles
ALTER TABLE ScenarioFiles 
ADD FilePath varchar(250);
--ADD Column Comments in ScenarioProjectMapper
ALTER TABLE ScenarioProjectMapper 
ADD Comments varchar(250);