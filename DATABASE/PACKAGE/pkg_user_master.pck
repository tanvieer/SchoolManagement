create or replace package pkg_user_master is

  -- Author  : TANVI
  -- Created : 6/11/2021 7:53:53 PM
  -- Purpose : 

  -- Public type declarations

  procedure sp_sys_user_master_gk(p_username    in nvarchar2,
                                  p_out         out number,
                                  p_err_code    out nvarchar2,
                                  p_err_msg     out nvarchar2,
                                  T_CURSOR      out sys_refcursor) 

end pkg_user_master;
/
create or replace package body pkg_user_master is


  procedure sp_sys_verify_user(p_username in nvarchar2,
                               p_password in nvarchar2,
                               T_CURSOR   out sys_refcursor) 
   is
     v_count number(8);
  
  begin
  
  
  
    open T_CURSOR for
      select t.id,
             t.username,
             t.email,
             t.first_name,
             t.last_name,
             t.phone_number,
             t.password,
             t.enc_key,
             t.role_id,
             (select role_name from sys_role where role_id = t.role_id) as role_name
        from sys_user_master t
       where t.username = 'admin';
  
  end sp_sys_verify_user;








  procedure sp_sys_user_master_gk(p_username    in nvarchar2,
                                  p_out         out number,
                                  p_err_code    out nvarchar2,
                                  p_err_msg     out nvarchar2,
                                  T_CURSOR      out sys_refcursor) 
   is
    --v_count number(8);
  
  begin
  
    open T_CURSOR for
      select t.id,
             t.username,
             t.email,
             t.first_name,
             t.last_name,
             t.phone_number,
             t.password,
             t.enc_key,
             t.role_id,
             (select role_name from sys_role where role_id = t.role_id) as role_name
        from sys_user_master t
       where t.username = 'admin';
  exception
    when others then
      p_out := sqlcode;
      p_err_msg := sqlerrm;
      rollback;
  end sp_sys_user_master_gk;

end pkg_user_master;
/
