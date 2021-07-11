create or replace package pkg_tuc_manage_op is

  -- Author  : TANVI
  -- Created : 6/11/2021 7:53:53 PM
  -- Purpose : 

  -- Public type declarations
  /* procedure sp_class_subject_map(p_activity   in char,
  p_subject_id in tuc_class_subject_map.subject_id%type,
  p_class_id   in tuc_class_subject_map.class_id%type,
  p_user_id    in TUC_SYS_USER_MAST.maker_id%type,
  p_out        out number,
  p_err_code   out varchar2,
  p_err_msg    out varchar2);*/
  procedure sp_tuc_class(p_activity   in char,
                         p_class_id   in out tuc_class.class_id%type,
                         p_class_name in tuc_class.class_name%type,
                         p_user_id    in tuc_class.maker_id%type,
                         p_out        out number,
                         p_err_code   out varchar2,
                         p_err_msg    out varchar2);
  procedure sp_tuc_class_gk(p_class_id in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor);

  procedure sp_tuc_class_ga(p_in       in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor);

  procedure sp_tuc_subject(p_activity     in char,
                           p_subject_id   in out tuc_subject.subject_id%type,
                           p_class_id     in tuc_subject.class_id%type,
                           p_subject_name in tuc_subject.subject_name%type,
                           p_teacher_id   in tuc_sys_user_mast.id%type,
                           p_user_id      in tuc_subject.maker_id%type,
                           p_out          out number,
                           p_err_code     out varchar2,
                           p_err_msg      out varchar2);

  procedure sp_tuc_subject_gk(p_subject_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor);

  procedure sp_tuc_subject_ga(p_in       in nvarchar2,
                              p_class_id in nvarchar2,
                              p_user_id  in nvarchar2,
                              p_out      out number,
                              p_err_code out nvarchar2,
                              p_err_msg  out nvarchar2,
                              T_CURSOR   out sys_refcursor);

  procedure sp_tuc_test(p_activity   in char,
                        p_test_id    in out tuc_test.test_id%type,
                        p_test_name  in tuc_test.test_name%type,
                        p_subject_id in tuc_test.subject_id%type,
                        p_test_date  in tuc_test.test_date%type,
                        p_user_id    in tuc_test.maker_id%type,
                        p_out        out number,
                        p_err_code   out varchar2,
                        p_err_msg    out varchar2);

  procedure sp_tuc_test_gk(p_test_id  in nvarchar2,
                           p_user_id  in nvarchar2,
                           p_out      out number,
                           p_err_code out nvarchar2,
                           p_err_msg  out nvarchar2,
                           T_CURSOR   out sys_refcursor);

  procedure sp_tuc_test_ga(p_in         in nvarchar2,
                           p_subject_id number,
                           p_user_id    in nvarchar2,
                           p_out        out number,
                           p_err_code   out nvarchar2,
                           p_err_msg    out nvarchar2,
                           T_CURSOR     out sys_refcursor);
  procedure sp_test_result_ga(p_test_id  in tuc_test.test_id%type,
                              p_user_id  in nvarchar2,
                              p_out      out number,
                              p_err_code out nvarchar2,
                              p_err_msg  out nvarchar2,
                              T_CURSOR   out sys_refcursor);

  procedure sp_tuc_result(p_activity   in char,
                          p_result_id  in out tuc_result.result_id%type,
                          p_test_id    in tuc_result.test_id%type,
                          p_grade      in tuc_result.grade%type,
                          p_student_id in tuc_result.student_id%type,
                          p_user_id    in tuc_result.maker_id%type,
                          p_out        out number,
                          p_err_code   out varchar2,
                          p_err_msg    out varchar2);

  procedure sp_tuc_result_gk(p_result_id in nvarchar2,
                             p_user_id   in nvarchar2,
                             p_out       out number,
                             p_err_code  out nvarchar2,
                             p_err_msg   out nvarchar2,
                             T_CURSOR    out sys_refcursor);

end pkg_tuc_manage_op;
/
create or replace package body pkg_tuc_manage_op is

  --mng-1016

  /* procedure sp_class_subject_map(p_activity   in char,
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
      v_count number(5);
    
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
          P_OUT := 1;
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
  */
  procedure sp_tuc_class(p_activity   in char,
                         p_class_id   in out tuc_class.class_id%type,
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
    if p_activity <> 'D' then
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
    end if;
  
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
           set u.class_id = 0
         where class_id = p_class_id
           AND STATUS = 'R';
      
        update tuc_class u
           set u.STATUS = 'D'
         where u.class_id = p_class_id
           AND u.STATUS = 'R';
      
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
        P_OUT := 1;
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
  
    if p_in = 1 then
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
           and class_id <> 0
         order by class_id;
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
                           p_subject_id   in out tuc_subject.subject_id%type,
                           p_class_id     in tuc_subject.class_id%type,
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
    V_STATUS                tuc_subject.STATUS%TYPE;
    v_teacher_id            tuc_sys_user_mast.id%type;
    v_count                 number(8);
    v_existing_subject_name tuc_subject.subject_name%type;
  
  begin
  
    p_out   := 0;
    v_count := 0;
  
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
  
    if p_activity = 'D' OR p_activity = 'U' OR p_activity = 'A' then
    
      if p_out = 0 then
        pkg_tuc_user_mast.is_null('subject id',
                                  p_subject_id,
                                  'mng-sp_tuc_subject',
                                  p_out,
                                  p_err_code,
                                  p_err_msg);
      else
        raise L_USER_ERR;
      end if;
    
    else
    
      if p_out = 0 then
        select count(1)
          into v_count
          from tuc_subject
         where upper(subject_name) = trim(upper(p_subject_name));
      
        if v_count > 0 then
          p_out      := 1;
          p_err_code := 'mng-1030';
          p_err_msg  := initcap(trim(p_subject_name) ||
                                ' This subject already exists in system!');
          ROLLBACK;
          RAISE L_USER_ERR;
        end if;
      else
        raise l_user_err;
      end if;
    
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
    
      IF P_ACTIVITY = 'I' THEN
      
        select nvl(max(subject_id), 0) + 1
          into p_subject_id
          from tuc_subject;
      
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
            p_err_code := 'mng-1033';
            p_err_msg  := initcap('No active teacher found by username : ' ||
                                  p_teacher_id);
            ROLLBACK;
            raise l_user_err;
        end;
      
        insert into tuc_subject
          (subject_id,
           subject_name,
           teacher_id,
           class_id,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (P_subject_id,
           trim(P_subject_name),
           v_teacher_id,
           p_class_id,
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
         where subject_id = p_subject_id
           AND STATUS = 'R';
      
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
      
        if V_STATUS = 'A' then
          p_out      := 1;
          p_err_code := 'mng-1028';
          p_err_msg  := initcap('This subject is already archived, you cannot change any property.');
          ROLLBACK;
          RAISE L_USER_ERR;
        elsif V_STATUS = 'D' then
          p_out      := 1;
          p_err_code := 'mng-1029';
          p_err_msg  := initcap('This subject is already deleted, you cannot change any property.');
          ROLLBACK;
          RAISE L_USER_ERR;
        end if;
      
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
            p_err_code := 'mng-1031';
            p_err_msg  := initcap('No active teacher found by username : ' ||
                                  p_teacher_id);
            ROLLBACK;
            raise l_user_err;
        end;
      
        if p_out = 0 then
          select count(1)
            into v_count
            from tuc_subject
           where upper(subject_name) = trim(upper(p_subject_name));
        
          select upper(subject_name)
            into v_existing_subject_name
            from tuc_subject
           where subject_id = p_subject_id;
        
          if v_count > 0 and
             v_existing_subject_name <> trim(upper(p_subject_name)) then
            p_out      := 1;
            p_err_code := 'mng-1032';
            p_err_msg  := initcap(trim(p_subject_name) ||
                                  ' This subject already exists in system!');
            ROLLBACK;
            RAISE L_USER_ERR;
          end if;
        else
          raise l_user_err;
        end if;
      
        update tuc_subject s
           set s.subject_name   = trim(p_subject_name),
               s.teacher_id     = v_teacher_id,
               s.class_id       = p_class_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where subject_id = p_subject_id;
      
        commit;
        p_err_msg := initcap('subject updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        update tuc_subject s
           set s.STATUS           = 'D',
               s.last_update_by   = p_user_id,
               s.last_update_time = sysdate
         where s.subject_id = p_subject_id
           AND s.STATUS = 'R';
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
        P_OUT := 1;
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
             (select first_name || ' ' || last_name
                from tuc_sys_user_mast
               where id = c.teacher_id) as teacher_full_name,
             class_id,
             (select class_name from tuc_class where class_id = c.class_id) as class_name,
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
                              p_class_id in nvarchar2,
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
    if p_in = 1 then
      open T_CURSOR for
        select subject_id,
               subject_name,
               CASE
                 WHEN status = 'A' THEN
                  'Archived'
                 WHEN status = 'D' THEN
                  'Deleted'
                 WHEN status = 'R' THEN
                  'Active'
                 ELSE
                  status
               END as status,
               teacher_id,
               (select username
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_username,
               (select first_name || ' ' || last_name
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_full_name,
               class_id,
               (select class_name from tuc_class where class_id = s.class_id) as class_name,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_subject s
         where s.status <> 'D'
         order by subject_id;
    elsif p_in = 2 then
      open T_CURSOR for
        select subject_id,
               subject_name,
               CASE
                 WHEN status = 'A' THEN
                  'Archived'
                 WHEN status = 'D' THEN
                  'Deleted'
                 WHEN status = 'R' THEN
                  'Active'
                 ELSE
                  status
               END as status,
               teacher_id,
               (select username
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_username,
               (select first_name || ' ' || last_name
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_full_name,
               class_id,
               (select class_name from tuc_class where class_id = s.class_id) as class_name,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_subject s
         where s.status <> 'D'
           and class_id = p_class_id
         order by subject_id;
    ELSIF p_in = 3 then
      open T_CURSOR for
        select subject_id,
               subject_name,
               CASE
                 WHEN status = 'A' THEN
                  'Archived'
                 WHEN status = 'D' THEN
                  'Deleted'
                 WHEN status = 'R' THEN
                  'Active'
                 ELSE
                  status
               END as status,
               teacher_id,
               (select username
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_username,
               (select first_name || ' ' || last_name
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_full_name,
               class_id,
               (select class_name from tuc_class where class_id = s.class_id) as class_name,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_subject s
         where s.status = 'R'
         order by subject_id;
    end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_subject_ga;

  /*************************************************************************/

  procedure sp_tuc_test(p_activity   in char,
                        p_test_id    in out tuc_test.test_id%type,
                        p_test_name  in tuc_test.test_name%type,
                        p_subject_id in tuc_test.subject_id%type,
                        p_test_date  in tuc_test.test_date%type,
                        p_user_id    in tuc_test.maker_id%type,
                        p_out        out number,
                        p_err_code   out varchar2,
                        p_err_msg    out varchar2) as
  
    /*****************************************************************************************************
    NAME         : sp_tuc_test
    PURPOSE      : To insert update delete archive a test
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
  
    l_row_count number(8);
    -- v_count      number(5);
    V_STATUS     tuc_test.STATUS%TYPE;
    v_subject_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF p_activity <> 'I' THEN
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('test ID',
                                  p_test_id,
                                  'mng-sp_tuc_test',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                                p_activity,
                                'mng-sp_tuc_test',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('p_subject_id',
                                  p_subject_id,
                                  'mng-sp_tuc_test',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('test Name',
                                  p_test_name,
                                  'mng-sp_tuc_test',
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
    
      IF P_ACTIVITY = 'I' THEN
      
        begin
          select subject_id
            into v_subject_id
            from tuc_subject u
           where u.subject_id = p_subject_id
             and status <> 'D';
        
          select count(1)
            into l_row_count
            from tuc_test
           where test_id = p_test_id
             and status in ('A', 'D');
        
          if l_row_count > 0 then
            p_out      := 1;
            p_err_code := 'mng-1024';
            p_err_msg  := initcap('this test is already archived or deleted.');
            raise l_user_err;
          end if;
        
        exception
          when others then
            p_out      := 1;
            p_err_code := 'mng-1043';
            p_err_msg  := initcap('No active subject found by p_subject_id : ' ||
                                  p_subject_id);
            raise l_user_err;
        end;
      
        select nvl(max(test_id), 0) + 1 into p_test_id from tuc_test;
        insert into tuc_test
          (test_id,
           test_name,
           subject_id,
           test_date,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (p_test_id,
           p_test_name,
           p_subject_id,
           p_test_date,
           'R',
           p_user_id,
           sysdate,
           p_user_id,
           sysdate);
      
        commit;
        p_err_msg := initcap('New test created successfully! test Id = ' ||
                             p_test_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- Archiving Test 
      
        update tuc_test
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where test_id = p_test_id
           AND STATUS = 'R';
      
        commit;
        p_err_msg := initcap('test archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        begin
          select subject_id
            into v_subject_id
            from tuc_subject u
           where u.subject_id = p_subject_id
             and status <> 'D';
        
          select count(1)
            into l_row_count
            from tuc_test
           where test_id = p_test_id
             and status in ('A', 'D');
        
          if l_row_count > 0 then
            p_out      := 1;
            p_err_code := 'mng-1024';
            p_err_msg  := initcap('this test is already archived or deleted.');
            raise l_user_err;
          end if;
        
        exception
          when others then
            p_out      := 1;
            p_err_code := 'mng-1043';
            p_err_msg  := initcap('No active subject found by p_subject_id : ' ||
                                  p_subject_id);
            raise l_user_err;
        end;
      
        update tuc_test s
           set s.test_name      = p_test_name,
               s.subject_id     = p_subject_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where test_id = p_test_id
           and status = 'R';
      
        commit;
        p_err_msg := initcap('test updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
      
        update tuc_test s
           set s.status         = 'D',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where test_id = p_test_id
           AND STATUS = 'R';
        commit;
        p_err_msg := initcap('test deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1019';
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
        P_OUT := 1;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1020';
        p_err_msg  := initcap('test id already exist.');
        ROLLBACK;
      end;
    
    when EXCP_FK_CONSTRAINT_VIOLATED then
      begin
        p_out      := 1;
        p_err_code := 'mng-1023';
        p_err_msg  := initcap('Subject ID not found.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1021';
      p_err_msg  := initcap('unexpected error in sp_tuc_test ~ ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_test;

  procedure sp_tuc_test_gk(p_test_id  in nvarchar2,
                           p_user_id  in nvarchar2,
                           p_out      out number,
                           p_err_code out nvarchar2,
                           p_err_msg  out nvarchar2,
                           T_CURSOR   out sys_refcursor) is
  
    /*****************************************************************************************************
    NAME         : sp_tuc_test_gk
    PURPOSE      : To to get specific test info
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_test_gk',
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
      select test_id,
             test_name,
             subject_id,
             (select subject_name
                from tuc_subject
               where subject_id = c.subject_id) as subject_name,
             test_id,
             CASE
               WHEN c.status = 'A' THEN
                'Archived'
               WHEN c.status = 'D' THEN
                'Deleted'
               WHEN c.status = 'R' THEN
                'Active'
               ELSE
                c.status
             END as status,
             to_char(c.test_date, 'DD-MON-YYYY') as test_date
        from tuc_test c
       where c.status <> 'D'
         and c.test_id = p_test_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1022';
      p_err_msg  := initcap('No Active test found Found by test ID = ') ||
                    p_test_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_test_gk;

  procedure sp_tuc_test_ga(p_in         in nvarchar2,
                           p_subject_id number,
                           p_user_id    in nvarchar2,
                           p_out        out number,
                           p_err_code   out nvarchar2,
                           p_err_msg    out nvarchar2,
                           T_CURSOR     out sys_refcursor) is
    /*****************************************************************************************************
    NAME         : sp_tuc_test_ga
    PURPOSE      : To to get list of test by subject id
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_test_ga',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
    if p_in = 1 then
      open T_CURSOR for
        select test_id,
               test_name,
               CASE
                 WHEN s.status = 'A' THEN
                  'Archived'
                 WHEN s.status = 'D' THEN
                  'Deleted'
                 WHEN s.status = 'R' THEN
                  'Active'
                 ELSE
                  s.status
               END as status,
               subject_id,
               (select t.subject_name
                  from tuc_subject t
                 where t.subject_id = s.subject_id) as subject_name,
               to_char(s.test_date, 'DD-MON-YYYY') as test_date
          from tuc_test s
         where s.status <> 'D'
           and (s.subject_id = p_subject_id or p_subject_id is null)
         order by test_id;
    end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_test_ga;

  procedure sp_test_result_ga(p_test_id  in tuc_test.test_id%type,
                              p_user_id  in nvarchar2,
                              p_out      out number,
                              p_err_code out nvarchar2,
                              p_err_msg  out nvarchar2,
                              T_CURSOR   out sys_refcursor) is
    /*****************************************************************************************************
    NAME         : sp_test_result_ga
    PURPOSE      : To to get list of test by subject id
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_test_id',
                                p_test_id,
                                'mng- sp_test_result_ga',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_test_result_ga',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
    if P_OUT = 0 then
      open T_CURSOR for
        select result_id,
               test_id,
               grade,
               case
                 when r.status = 'A' then
                  'ARCHIVED'
                 WHEN R.STATUS = 'R' THEN
                  'ACTIVE'
                 WHEN R.STATUS = 'D' THEN
                  'DELETED'
                 ELSE
                  R.STATUS
               END AS status,
               student_id,
               usr.username,
               usr.first_name,
               usr.last_name
          from tuc_result r
          left join tuc_sys_user_mast usr
            on r.student_id = usr.id
         where r.status <> 'D'
           and usr.status <> 'D';
      p_err_msg := 'Data found successfully.';
    end if;
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_test_result_ga;

  procedure sp_tuc_result(p_activity   in char,
                          p_result_id  in out tuc_result.result_id%type,
                          p_test_id    in tuc_result.test_id%type,
                          p_grade      in tuc_result.grade%type,
                          p_student_id in tuc_result.student_id%type,
                          p_user_id    in tuc_result.maker_id%type,
                          p_out        out number,
                          p_err_code   out varchar2,
                          p_err_msg    out varchar2) as
  
    /*****************************************************************************************************
    NAME         : sp_tuc_result
    PURPOSE      : To insert update delete archive a test result
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
  
    l_row_count number(8);
    -- v_count      number(5);
    V_STATUS     tuc_result.STATUS%TYPE;
    v_subject_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                                p_activity,
                                'mng-sp_tuc_result',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF p_activity <> 'I' THEN
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Result ID',
                                  p_result_id,
                                  'mng-sp_tuc_result',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Test Id',
                                  p_test_id,
                                  'mng-sp_tuc_result',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Grade',
                                  p_grade,
                                  'mng-sp_tuc_result',
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
    
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(result_id), 0) + 1 into p_result_id from tuc_result;
      
        insert into tuc_result
          (result_id,
           test_id,
           grade,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time,
           student_id)
        values
          (p_result_id,
           p_test_id,
           p_grade,
           'R',
           p_user_id,
           sysdate,
           p_user_id,
           sysdate,
           p_student_id);
        commit;
        p_err_msg := initcap('New result added successfully! result Id = ' ||
                             p_result_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- Archiving Test 
      
        update tuc_result
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;
      
        commit;
        p_err_msg := initcap('Result archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        -- deasign subject from test  
      
        BEGIN
          SELECT STATUS
            INTO V_STATUS
            FROM tuc_result S
           WHERE S.result_ID = P_result_ID;
        EXCEPTION
          WHEN OTHERS THEN
            p_out      := 1;
            p_err_code := 'mng-1037';
            p_err_msg  := initcap('Result NOT FOUND BY Result ID: ' ||
                                  P_result_ID);
            ROLLBACK;
            RAISE L_USER_ERR;
        END;
      
        update tuc_result s
           set s.grade          = p_grade,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = P_result_ID;
      
        commit;
        p_err_msg := initcap('Grade updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
      
        update tuc_result s
           set s.status         = 'D',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = P_result_ID;
        commit;
        p_err_msg := initcap('Result deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1038';
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
        P_OUT := 1;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1039';
        p_err_msg  := initcap('Result id already exist.');
        ROLLBACK;
      end;
    
    when EXCP_FK_CONSTRAINT_VIOLATED then
      begin
        p_out      := 1;
        p_err_code := 'mng-1040';
        p_err_msg  := initcap('Test ID or Student Id not found.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1041';
      p_err_msg  := initcap('unexpected error in sp_tuc_result ~ ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_result;

  procedure sp_tuc_result_gk(p_result_id in nvarchar2,
                             p_user_id   in nvarchar2,
                             p_out       out number,
                             p_err_code  out nvarchar2,
                             p_err_msg   out nvarchar2,
                             T_CURSOR    out sys_refcursor) is
  
    /*****************************************************************************************************
    NAME         : sp_tuc_result_gk
    PURPOSE      : To get specific result by result id
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_result_gk',
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
      select result_id,
             grade,
             test_id,
             CASE
               WHEN r.status = 'A' THEN
                'Archived'
               WHEN r.status = 'D' THEN
                'Deleted'
               WHEN r.status = 'R' THEN
                'Active'
               ELSE
                r.status
             END as status,
             student_id,
             usr.username,
             usr.first_name,
             usr.last_name
        from tuc_result r
        left join tuc_sys_user_mast usr
          on r.student_id = usr.id
       where r.status <> 'D'
         and r.result_id = p_result_id
         and usr.status <> 'D';
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1042';
      p_err_msg  := initcap('No Active result found Found by result ID = ') ||
                    p_result_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_result_gk;

/*  
  procedure sp_tuc_result   (p_activity       in char,
                               p_result_id      in out tuc_result.result_id%type,
                               p_student_id     in tuc_result.student_id%type,
                               p_grade          in tuc_result.grade%type,
                               p_test_id        in tuc_result.test_id%type, 
                               p_user_id      in tuc_result.maker_id%type,
                               p_out          out number,
                               p_err_code     out varchar2,
                               p_err_msg      out varchar2) as
  
  \*****************************************************************************************************
NAME         : sp_tuc_result
PURPOSE      : To insert update delete archive a result
MODULE       : tuc test
CREATED BY   : MOHAMMAD TANVIR ISLAM
Matriculation: #676614
EMAIL        : imoh@hrz.tu-chemnitz.de
CREATED AT   : 28-JUNE-2021

REVISIONS:

VERSION     DATE        AUTHOR                      DESCRIPTION
---------   ----------  -----------------           ------------------------------------
1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
*****************************************************************************************************\

  
   
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
    
    l_row_count  number(8);
   -- v_count      number(5);
    V_STATUS     tuc_result.STATUS%TYPE;
    v_test_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('result ID',
                              p_result_id,
                              'mng-sp_tuc_result',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                              p_activity,
                              'mng-sp_tuc_result',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('p_test_id',
                                p_test_id,
                                'mng-sp_tuc_result',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Grade',
                                p_grade,
                                'mng-sp_tuc_result',
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
        select test_id
          into v_test_id
          from tuc_test u
         where u.test_id = p_test_id
           and status <> 'D';
           
        select count(1)
          into l_row_count
          from tuc_result
         where result_id = p_result_id
           and status in ('A', 'D');
        
        if  l_row_count > 0 then
           p_out      := 1;
           p_err_code := 'mng-1025';
           p_err_msg  := initcap('this result is already archived or deleted.'); 
           raise l_user_err;
        end if;
         
      exception
        when others then
          p_out      := 1;
          p_err_code := 'mng-1026';
          p_err_msg  := initcap('No active test found by p_test_id : ' || p_test_id); 
          raise l_user_err;
      end;
    
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(result_id), 0) + 1
          into p_result_id
          from tuc_result;
       insert into tuc_result
         (result_id,
          test_id,
          student_id,
          grade,
          status,
          maker_id,
          maker_time,
          last_update_by,
          last_update_time)
       values
         (p_result_id,
          p_test_id,
          p_student_id,
          p_grade,
          'R',
          p_user_id,
          sysdate,
          p_user_id,
          sysdate); 
     
        commit;
        p_err_msg := initcap('New result created successfully! result Id = ' ||  p_result_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- Archiving result 
      
        update tuc_result
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;
      
        commit;
        p_err_msg := initcap('result archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        -- deasign test from result  
      
        BEGIN
          SELECT STATUS
            INTO V_STATUS
            FROM tuc_result S
           WHERE S.result_ID = P_result_ID;
        EXCEPTION
          WHEN OTHERS THEN
            p_out      := 1;
            p_err_code := 'mng-1027';
            p_err_msg  := initcap('result NOT FOUND BY result ID: ' ||
                                  P_result_ID);
            ROLLBACK;
            RAISE L_USER_ERR;
        END;
        
        if V_STATUS = 'A'
          then
              p_out      := 1;
              p_err_code := 'mng-1034';
              p_err_msg  := initcap('result is already archived '); 
              RAISE L_USER_ERR;
         elsif V_STATUS = 'D' 
           then
            p_out      := 1;
            p_err_code := 'mng-1035';
            p_err_msg  := initcap('result is already deleted '); 
            RAISE L_USER_ERR;
         end if;
      
        update tuc_result s
           set s.grade          = p_grade, 
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;
      
        commit;
        p_err_msg := initcap('Grade updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
      
        update tuc_result s
           set s.status         = 'D',
               s.test_id     = p_test_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;         
        commit;
        p_err_msg := initcap('result deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1036';
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
        P_OUT := 1;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1037';
        p_err_msg  := initcap('result id already exist.');
        ROLLBACK;
      end;
    
    when EXCP_FK_CONSTRAINT_VIOLATED then
      begin
        p_out      := 1;
        p_err_code := 'mng-1038';
        p_err_msg  := initcap('test ID not found.');
        ROLLBACK;
      end;      
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1039';
      p_err_msg  := initcap('unexpected error in sp_tuc_result ~ ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_result;

 

  procedure sp_tuc_result_ga( p_in         in nvarchar2,
                              p_test_id    in number,
                              p_student_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor) is
  
\*****************************************************************************************************
NAME         : sp_tuc_result_ga
PURPOSE      : To get list of result by test id or student_id
MODULE       : tuc test
CREATED BY   : MOHAMMAD TANVIR ISLAM
Matriculation: #676614
EMAIL        : imoh@hrz.tu-chemnitz.de
CREATED AT   : 28-JUNE-2021

REVISIONS:

VERSION     DATE        AUTHOR                      DESCRIPTION
---------   ----------  -----------------           ------------------------------------
1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
*****************************************************************************************************\

  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_result_ga',
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
        select result_id,
               grade,
               status,
               test_id,               
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_result s
         where s.status <> 'D' 
         and (s.test_id = p_test_id or p_test_id is null)
         and (s.student_id = p_student_id or p_student_id is null);
   end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_result_ga;
 
*/
end pkg_tuc_manage_op;
/
