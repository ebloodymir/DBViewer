select  ucc.COLUMN_NAME,
        uc.constraint_type,
        uc.constraint_name,
        uc.TABLE_NAME
from    user_cons_columns ucc
        inner join all_constraints uc
            on ucc.constraint_name = uc.constraint_name
where   ucc.position is not null
        and ucc.table_name = 'STUDENTS'
 ;
 
SELECT  a.table_name, a.column_name, a.constraint_name, 
        c_pk.table_name r_table_name, c_pk.constraint_name r_pk
FROM    user_cons_columns a
        JOIN user_constraints c 
            ON a.owner = c.owner
            AND a.constraint_name = c.constraint_name
        JOIN user_constraints c_pk 
            ON c.r_owner = c_pk.owner
            AND c.r_constraint_name = c_pk.constraint_name
;

select  COLUMN_NAME,
        DATA_TYPE,
        DATA_LENGTH,
        DATA_PRECISION
from    ALL_TAB_COLUMNS
where   TABLE_NAME = 'STUDENTS'
;