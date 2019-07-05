#!/bin/bash
source config.sh

#very slow /./
for db in $database
do
	tables=`mysql -u $dbUser -p$dbPasswd -h 127.0.0.1  --batch -N -e "select table_name from information_schema.tables where table_type IN('BASE TABLE','SYSTEM VERSIONED') and table_schema='$db';"`
	views=`mysql -u $dbUser -p$dbPasswd -h 127.0.0.1  --batch -N -e "select table_name from information_schema.tables where table_type='VIEW' and table_schema='$db';"`

    dat=`date +%s`;

    # backup all items as separate files
    for table in $tables; do
        echo "table-$db.$table"
        mysqldump -u $dbUser -p$dbPasswd -h 127.0.0.1  --single-transaction  --quick --opt --skip-add-drop-table --no-data $db $table  > $db.$table.schema.sql
    done
    
    for table in $tables; do
        echo "table-$db.$table"
        mysqldump -u $dbUser -p$dbPasswd -h 127.0.0.1  --single-transaction  --quick --opt --skip-add-drop-table --no-create-info $db $table  > $db.$table.$dat.sql
    done

    for view in $views; do
        echo "view-$db.$view"
        mysqldump -u $dbUser -p$dbPasswd -h 127.0.0.1  --single-transaction  --quick --opt --skip-add-drop-table $db $view  > $db.$view.schema.sql
    done

done

git add *schema.sql -f
