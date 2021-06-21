create or replace package pkg_tuc_manage_op is

  -- Author  : TANVI
  -- Created : 6/11/2021 7:53:53 PM
  -- Purpose : 

  -- Public type declarations
  procedure sp_class_subject_map(p_activity   in char,
                                 p_subject_id in tuc_class_subject_map.subject_id%type,
                                 p_class_id   in tuc_class_subject_map.class_id%type,
                                 p_user_id    in TUC_SYS_USER_MAST.maker_id%type,
                                 p_out        out number,
                                 p_err_code   out varchar2,
                                 p_err_msg    out varchar2);

end pkg_tuc_manage_op;
/
create or replace package body pkg_tuc_manage_op is

--mng-1016

  procedure sp_class_subject_map(p_activity   in char,
                                 p_subject_id in tuc_class_subject_map.subject_id%type,
                                 p_class_id   in tuc_class_subject_map.class_id%type,
                                 p_user_id    in TUC_SYS_USER_MAST.maker_id%type,
                                 p_out        out number,
                                 p_err_code   out varchar2,
                                 p_err_msg    out varchar2) as
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id   TUC_SYS_USER_MAST.id%type;   
    v_count     number(5);
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('subject ID',
                              p_subject_id,
                              'mng-sp_class_subject_map',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('CLASS ID',
                              p_class_id,
                              'mng-sp_class_subject_map',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                              p_activity,
                              'mng-sp_class_subject_map',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
      IF P_ACTIVITY = 'I' THEN
        -- assign subject to class
      
        v_count := 0;
        select count(1)
          into v_count
          from TUC_SYS_USER_MAST t
         where t.username = p_subject_id
           and t.status <> 'D';
      
        if v_count < 1 then
          p_out      := 1;
          p_err_code := 'mng-1001';
          p_err_msg  := initcap('No active subject found by username : ' ||
                                p_subject_id);
          raise L_USER_ERR;
        end if;
      
        v_count := 0;
        select count(1)
          into v_count
          from tuc_class t
         where t.class_id = p_class_id
           and t.status <> 'D';
      
        if v_count < 1 then
          p_out      := 1;
          p_err_code := 'mng-1002';
          p_err_msg  := initcap('No active class found by class id : ' ||
                                p_class_id);
          raise L_USER_ERR;
        end if;
      
        insert into tuc_class_subject_map
          (class_id,
           subject_id,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (p_class_id,
           p_subject_id,
           p_user_id,
           sysdate,
           p_user_id,
           sysdate);
        commit;
        p_err_msg := initcap('subject assigned successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        -- deasign subject from class
      
        delete tuc_class_subject_map
         where class_id = p_class_id
           and subject_id = p_subject_id;
        commit;
        p_err_msg := initcap('subject deassigned successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1003';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
        end;
      END IF;
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 0;
        ROLLBACK;
      END;
    WHEN EXCP_FK_CONSTRAINT_VIOLATED THEN
      p_out      := 1;
      p_err_code := 'mng-1004';
      p_err_msg  := initcap('subject not found');
      ROLLBACK;
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1005';
        p_err_msg  := initcap('subject already assignend in given class.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1006';
      p_err_msg  := initcap('unexpected error in sp_class_subject_map ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_class_subject_map;

  procedure sp_tuc_class(p_activity   in char,
                         p_class_id   out tuc_class.class_id%type,
                         p_class_name in tuc_class.class_name%type,
                         p_user_id    in tuc_class.maker_id%type,
                         p_out        out number,
                         p_err_code   out varchar2,
                         p_err_msg    out varchar2) as
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);  
   -- l_row_count number(8);
   -- v_count     number(5);
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                              p_activity,
                              'mng-sp_tuc_class',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'U' then
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Class ID',
                                p_class_id,
                                'mng-sp_tuc_class',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    end if;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('Class Name',
                              p_class_name,
                              'mng-sp_tuc_class',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(class_id), 0) + 1 into p_class_id from tuc_class;
      
        insert into tuc_class
          (class_id,
           class_name,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (P_class_id,
           P_class_name,
           'R',
           P_USER_ID,
           SYSDATE,
           P_USER_ID,
           SYSDATE);
        commit;
        p_err_msg := initcap('New class created successfully! Class Id = ' ||
                             p_class_id);
      
      ELSIF P_ACTIVITY = 'U' THEN
        update tuc_class u
           set u.class_name       = p_class_name,
               u.last_update_by   = p_user_id,
               u.last_update_time = sysdate
         where class_id = p_class_id;
        commit;
        p_err_msg := initcap('Class name updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        -- deasign STUDENTS from class    
        update tuc_sys_user_mast u
           set u.class_id = null
         where class_id = p_class_id;
      
        delete tuc_class where class_id = p_class_id;
        commit;
        p_err_msg := initcap('Class deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1007';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
        end;
      END IF;
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 0;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1008';
        p_err_msg  := initcap('Class id already exist.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1009';
      p_err_msg  := initcap('unexpected error in sp_tuc_class ') || sqlerrm;
      ROLLBACK;
  end sp_tuc_class;

  procedure sp_tuc_class_gk(p_class_id in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor) is
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_class_gk',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select class_id,
             class_name,
             status,
             maker_id,
             maker_time,
             last_update_by,
             last_update_time
        from tuc_class c
       where c.status <> 'D'
         and c.class_id = p_class_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1010';
      p_err_msg  := initcap('No Active Class found Found by Class ID = ') ||
                    p_class_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_class_gk;

  procedure sp_tuc_class_ga(p_in       in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_class_ga',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
    
    if p_in = 1 
     then
      open T_CURSOR for
        select class_id,
               class_name,
               status,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_class c
         where c.status <> 'D';
     end if;
  
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_class_ga;

  procedure sp_tuc_subject(p_activity     in char,
                           p_subject_id   out tuc_subject.subject_id%type,
                           p_subject_name in tuc_subject.subject_name%type,
                           p_teacher_id   in tuc_sys_user_mast.id%type,
                           p_user_id      in tuc_subject.maker_id%type,
                           p_out          out number,
                           p_err_code     out varchar2,
                           p_err_msg      out varchar2) as
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
    
   -- l_row_count  number(8);
   -- v_count      number(5);
    V_STATUS     tuc_subject.STATUS%TYPE;
    v_teacher_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('subject ID',
                              p_subject_id,
                              'mng-sp_tuc_subject',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                              p_activity,
                              'mng-sp_tuc_subject',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('p_teacher_id',
                                p_teacher_id,
                                'mng-sp_tuc_subject',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Subject Name',
                                p_subject_name,
                                'mng-sp_tuc_subject',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    end if;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
    
      begin
        select id
          into v_teacher_id
          from tuc_sys_user_mast u
         where upper(u.username) = upper(p_teacher_id)
           and u.role_id = 2
           and status <> 'D';
      exception
        when others then
          p_out      := 1;
          p_err_code := 'mng-1011';
          p_err_msg  := initcap('No active teacher found by username : ' ||
                                p_teacher_id);
          ROLLBACK;
          raise l_user_err;
      end;
    
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(subject_id), 0) + 1
          into p_subject_id
          from tuc_subject;
      
        insert into tuc_subject
          (subject_id,
           subject_name,
           teacher_id,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (P_subject_id,
           P_subject_name,
           v_teacher_id,
           'R',
           P_USER_ID,
           SYSDATE,
           P_USER_ID,
           SYSDATE);
        commit;
        p_err_msg := initcap('New subject created successfully! subject Id = ' ||
                             p_subject_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- deasign teacher from subject  
      
        update tuc_subject
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where subject_id = p_subject_id;
      
        commit;
        p_err_msg := initcap('subject archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        -- deasign teacher from subject  
      
        BEGIN
          SELECT STATUS
            INTO V_STATUS
            FROM tuc_subject S
           WHERE S.SUBJECT_ID = P_SUBJECT_ID;
        EXCEPTION
          WHEN OTHERS THEN
            p_out      := 1;
            p_err_code := 'mng-1012';
            p_err_msg  := initcap('SUBJECT NOT FOUND BY SUBJECT ID: ' ||
                                  P_SUBJECT_ID);
            ROLLBACK;
            RAISE L_USER_ERR;
        END;
      
        update tuc_subject s
           set s.subject_name   = 'A',
               s.teacher_id     = p_teacher_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where subject_id = p_subject_id;
      
        commit;
        p_err_msg := initcap('subject updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        -- deasign teacher from subject 
        delete tuc_class_subject_map where subject_id = p_subject_id;
        delete tuc_subject where subject_id = p_subject_id;
        commit;
        p_err_msg := initcap('subject deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1013';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
          RAISE L_USER_ERR;
        end;
      
      end if;
    
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 0;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1014';
        p_err_msg  := initcap('subject id already exist.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1015';
      p_err_msg  := initcap('unexpected error in sp_tuc_subject ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_subject;

  procedure sp_tuc_subject_gk(p_subject_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor) is
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_subject_gk',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select subject_id,
             subject_name,
             teacher_id,
             (select username from tuc_sys_user_mast where id = c.teacher_id) as teacher_username,
             (select first_name || ' ' || last_name from tuc_sys_user_mast where id = c.teacher_id) as teacher_full_name,             
             status,
             maker_id,
             maker_time,
             last_update_by,
             last_update_time
        from tuc_subject c
       where c.status <> 'D'
         and c.subject_id = p_subject_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1016';
      p_err_msg  := initcap('No Active subject found Found by subject ID = ') ||
                    p_subject_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_subject_gk;

  procedure sp_tuc_subject_ga(p_in       in nvarchar2,
                              p_user_id  in nvarchar2,
                              p_out      out number,
                              p_err_code out nvarchar2,
                              p_err_msg  out nvarchar2,
                              T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_subject_ga',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
   if p_in = 1 
     then
      open T_CURSOR for
        select subject_id,
               subject_name,
               status,
               teacher_id,
               (select username from tuc_sys_user_mast where id = s.teacher_id) as teacher_username,
               (select first_name || ' ' || last_name from tuc_sys_user_mast where id = s.teacher_id) as teacher_full_name,             
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_subject s
         where s.status <> 'D';
   end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_subject_ga;

end pkg_tuc_manage_op;
/
