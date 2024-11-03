#!/bin/bash 

psql -U postgres -d postgres -f create_db.sql
psql -U postgres -d asterisk_db -f configure_db.sql
psql -U asterisk -d asterisk_db -f fill_db.sql 
