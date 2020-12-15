

UPDATE [dbo].[Project]
   SET [ProjectStatus] = 'Active' WHERE ProjectID = 882;



ALTER TABLE Project ALTER COLUMN ProjectStatus varchar(20) NOT NULL;

