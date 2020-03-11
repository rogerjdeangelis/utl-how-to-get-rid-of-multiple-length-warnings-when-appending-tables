How to get rid of multiple length warnings when appending tables

Use sql 'union all'

github
https://tinyurl.com/tgfhp2m
https://github.com/rogerjdeangelis/utl-how-to-get-rid-of-multiple-length-warnings-when-appending-tables

SAS Forum
https://tinyurl.com/wpfu8tj
https://communities.sas.com/t5/SAS-Programming/PROC-SQL-UNION-unique-vs-with-duplicates/td-p/400297

*                _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| '_ \| '__/ _ \| '_ \| |/ _ \ '_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
;

proc append data=sashelp.class base=class_lng;
run;quit;

WARNING: Variable name has different lengths on BASE and DATA files (BASE 64 DATA 8).
WARNING: Variable sex has different lengths on BASE and DATA files (BASE 64 DATA 1).


*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

SASHELP.CLASS

data class_long;
  length name sex $64;
  set sashelp.class;
run;quit;



       WORKCLASS_LONG                SASHELP.CLASS

============================     =======================
#    Variable    Type    Len     Variable    Type    Len

1    name        Char     64     NAME        Char      8   ==> diff length
2    sex         Char     64     SEX         Char      1   ==> diff length
3    AGE         Num       8     AGE         Num       8
4    HEIGHT      Num       8     HEIGHT      Num       8
5    WEIGHT      Num       8     WEIGHT      Num       8


*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

SAS_LENGTH_FIX total obs=38

 Variables in Creation Order

#    Variable    Type    Len

1    NAME        Char     64
2    SEX         Char     64
3    AGE         Num       8
4    HEIGHT      Num       8
5    WEIGHT      Num       8

*_
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
;


proc sql;
  create
    table sas_length_fix as
  select
    *
  from
    sashelp.class
  union
    all
  select
    *
  from
    class_long
;quit;


7367  proc sql;
7368    create
7369      table sas_length_fix as
7370    select
7371      *
7372    from
7373      sashelp.class
7374    union
7375      all
7376    select
7377      *
7378    from
7379      class_long
7380  ;
NOTE: Table WORK.SAS_LENGTH_FIX created, with 38 rows and 5 columns.

7380!  quit;
NOTE: PROCEDURE SQL used (Total process time):
      real time           0.01 seconds
      user cpu time       0.00 seconds
      system cpu time     0.00 seconds
      memory              5639.78k
      OS Memory           34308.00k
      Timestamp           03/11/2020 04:55:45 PM
      Step Count                        1161  Switch Count  0



