alter session set "_ORACLE_SCRIPT"=true; 
CREATE USER schoolmgmt
IDENTIFIED BY schoolmgmt
DEFAULT TABLESPACE USERS 
PROFILE DEFAULT
ACCOUNT UNLOCK;
-- 5 Roles for schoolmgmt 
GRANT DBA TO schoolmgmt; 
GRANT CONNECT TO schoolmgmt; 