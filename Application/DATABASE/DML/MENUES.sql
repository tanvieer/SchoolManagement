prompt Importing table TUC_MENU...
set feedback off
set define off
insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (1, '/create-user', 'Create User', 1, 0, 'USERS', 'R', 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (2, '/user-list', 'All Users', 1, 0, 'USERS', 'R', 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (3, '/teacher-list', 'Teacher List', 1, 0, 'USERS', 'R', 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (4, '/pupils', 'Pupil List', 1, 0, 'USERS', 'R', 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:51:47', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (5, '/pupils', 'Pupil List', 2, 0, 'USERS', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (6, '/class-list', 'Class List', 1, 0, 'USERS', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (7, '/subject-list', 'Subject List', 1, 0, 'SUBJECT', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (8, '/test-list', 'Test List', 2, 0, 'TEST', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (9, '/test-edit/1', 'Test Edit', 2, 0, 'TEST', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (10, '/test-create', 'Test Create', 2, 0, 'TEST', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (11, '/result-list', 'Result List', 2, 0, 'RESULT', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (12, '/result-edit/1', 'Result Edit', 2, 0, 'RESULT', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (13, '/result-create', 'Result Create', 2, 0, 'RESULT', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (15, '/contact', 'HOME', 1, 0, 'INFO', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (16, '/contact', 'HOME', 2, 0, 'INFO', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

insert into TUC_MENU (ID, ROUTER_LINK, ROUTER_NAME, ROLE_ID, IS_SUB_MENU, MODULE_NAME, STATUS, MAKER_ID, MAKER_TIME, LAST_UPDATE_BY, LAST_UPDATE_TIME)
values (17, '/contact', 'HOME', 3, 0, 'INFO', 'R', 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'), 'SYSTEM', to_date('12-07-2021 21:52:06', 'dd-mm-yyyy hh24:mi:ss'));

prompt Done.
